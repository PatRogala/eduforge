module Instructor
  # Form Object to handle creation and updating of ProgrammingCourseLessons
  # including associated ProgrammingTask and potential new ProgrammingCourseChapter.
  class LessonForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    # --- Attributes ---
    # Lesson attributes
    attribute :title, :string
    attribute :content, :string # For ActionText, we'll handle this specially
    attribute :programming_course_chapter_id, :integer

    # Virtual attributes (from form, not directly on lesson)
    attribute :new_chapter_title, :string
    attribute :has_programming_task, :boolean, default: false

    # Nested Task attributes
    attribute :programming_task_attributes, default: {} # Store the nested hash

    # Context attributes
    attr_reader :lesson, :programming_course, :instructor, :programming_task

    delegate :content, to: :lesson

    # --- Validations ---
    validates :title, presence: true
    validates :programming_course_chapter_id, presence: { unless: -> { new_chapter_title.present? } }
    validates :new_chapter_title, presence: { unless: -> { programming_course_chapter_id.present? } }
    validate :programming_task_validations # Custom validation for nested task

    # --- Initialization ---
    def initialize(params = {}, programming_course:, instructor:, lesson: nil)
      # Filter params for form attributes BEFORE super
      form_params = params.slice(*self.class.attribute_names, :programming_task_attributes)
      form_attrs_from_params = form_params.except(:programming_task_attributes)
      super(form_attrs_from_params) # Initialize form attributes primarily from params

      @programming_course = programming_course
      @instructor = instructor
      @lesson = lesson || programming_course.programming_course_lessons.build

      # --- Populate form attributes from existing lesson IF NOT explicitly overridden by params ---
      if @lesson.persisted?
        # Populate title only if not provided in params
        self.title = @lesson.title if title.blank? && params[:title].blank?

        # Populate chapter_id only if neither chapter_id nor new_chapter_title is in params
        if programming_course_chapter_id.blank? && new_chapter_title.blank? &&
           params[:programming_course_chapter_id].blank? && params[:new_chapter_title].blank?
          self.programming_course_chapter_id = @lesson.programming_course_chapter_id
        end
      end
      # --- End Population Logic ---

      # Store raw content param and assign to lesson
      @content_param = params[:content] if params.key?(:content)
      @lesson.content = @content_param if @content_param

      # Assign nested attributes AFTER potential defaults are set
      self.programming_task_attributes = params[:programming_task_attributes] if params.key?(:programming_task_attributes)

      # Initialize or build the task based on params and existing lesson state
      initialize_or_build_task(params)

      # Set has_programming_task based on existing task or param
      @has_programming_task = params.key?(:has_programming_task) ? params[:has_programming_task] == "1" : @programming_task&.persisted?

      # Re-populate task attributes specifically for edit form load (params empty)
      return unless @lesson.persisted? && params.empty?

      self.programming_task_attributes = @lesson.programming_task&.attributes&.symbolize_keys || {}
      @has_programming_task = @lesson.programming_task&.persisted?
    end

    # --- Public Interface ---

    def submit
      # Assign the latest content from params directly before validation/saving
      @lesson.content = @content_param if @content_param.present?

      # Check form object validity (which now includes lesson_model_validations)
      unless valid?
        # Errors are already merged by the validation callbacks
        return false
      end

      ActiveRecord::Base.transaction do
        created_chapter = create_chapter_if_needed
        # Update the form object's chapter_id if a new chapter was created
        self.programming_course_chapter_id = created_chapter.id if created_chapter&.persisted?

        # Assign attributes to the lesson object before saving
        @lesson.assign_attributes(lesson_attributes_for_save)

        # Process task attributes based on the checkbox
        handle_task_assignment

        @lesson.save!
      end

      true # Return true on successful transaction
    rescue ActiveRecord::RecordInvalid => e
      # Handle potential save errors not caught by initial validation (rare with `save!`)
      errors.add(:base, "Failed to save lesson: #{e.message}")
      merge_lesson_errors # Ensure model errors are visible
      false
    end

    # --- Methods needed for form_with ---
    delegate :persisted?, to: :@lesson

    def model_name
      # Use ActiveModel::Name.new for compatibility with form_with parameter namespacing
      ActiveModel::Name.new(self.class, nil, "Instructor::LessonForm")
    end

    delegate :to_key, to: :@lesson

    def to_model
      self # Allows form_with to treat this object like a model
    end

    # Expose chapters for the select dropdown in the view
    def available_chapters
      programming_course.programming_course_chapters.order(:title)
    end

    private

    # --- Private Helpers ---

    def initialize_or_build_task(params)
      @programming_task = @lesson.programming_task

      # Only build a *new* task if the checkbox says so and no task exists
      # Task attributes might be present from a failed validation attempt
      if params.key?(:has_programming_task) && params[:has_programming_task] == "1" && @programming_task.nil?
        @programming_task = @lesson.build_programming_task
      elsif @programming_task.nil? && params.key?(:programming_task_attributes) && !params[:programming_task_attributes].empty?
        # Rebuild if needed for validation display
        @programming_task = @lesson.build_programming_task
      end

      # Assign attributes if the task object exists (either found or built)
      return unless @programming_task && params.key?(:programming_task_attributes)

      attrs_to_assign = params[:programming_task_attributes].except(:_destroy) # Don't assign _destroy yet
      @programming_task.assign_attributes(attrs_to_assign)
    end

    def create_chapter_if_needed
      return if new_chapter_title.blank?

      chapter = programming_course.programming_course_chapters.create(title: new_chapter_title.strip)
      unless chapter.persisted?
        # Add errors from chapter creation to the form object
        chapter.errors.full_messages.each do |msg|
          errors.add(:new_chapter_title, msg)
        end
        raise ActiveRecord::Rollback # Ensure transaction fails
      end
      chapter
    end

    def lesson_attributes_for_save
      {
        title: title,
        # Content is handled directly on @lesson
        programming_course_chapter_id: programming_course_chapter_id # Use the potentially updated chapter_id from form
      }
    end

    # Prepare nested attributes based on the checkbox state
    def processed_task_attributes
      return {} if programming_task_attributes.nil? # Handle case where it wasn't in params

      final_attrs = programming_task_attributes.dup # Start with attributes from params

      # If checkbox is UNCHECKED
      if has_programming_task # Checkbox is CHECKED
        # Ensure _destroy is not set or is false if task is meant to be saved/created
        final_attrs.delete(:_destroy)
        # If creating a new task ensure required fields are potentially present
        # (validation will catch missing ones)
      else
        return {} unless @programming_task&.persisted?

        # Mark existing task for destruction
        final_attrs[:id] = @programming_task.id # Ensure ID is present
        final_attrs[:_destroy] = "1"

        # If checkbox is unchecked and task doesn't exist, clear attributes
        # Don't send any task attributes

      end

      final_attrs
    end

    # Add lesson/task errors to the form object's errors
    def merge_lesson_errors
      # Merge errors from the underlying lesson model if they exist
      @lesson&.errors&.each do |error|
        # Avoid duplicating errors already on the form object for direct attributes
        errors.add(error.attribute, error.message) unless errors.messages.key?(error.attribute) && errors.messages[error.attribute].include?(error.message)
      end

      # Merge errors from the underlying task model if it exists and has errors
      return unless @programming_task&.errors&.any?

      @programming_task.errors.messages.each do |field, messages|
        attr_name = :"programming_task_#{field}"
        messages.each do |msg|
          # Avoid duplicate messages for the same task attribute
          errors.add(attr_name, msg) unless errors.messages.key?(attr_name) && errors.messages[attr_name].include?(msg)
        end
      end
    end

    # Validate the underlying lesson model
    def lesson_valid?
      # Manually assign attributes to the lesson to check its validity including nested task
      @lesson.assign_attributes(
        title: title,
        content: content,
        programming_course_chapter_id: programming_course_chapter_id # Use potentially updated chapter_id
      )
      # Assign task attributes for validation IF the task should exist
      if has_programming_task && programming_task_attributes.present? && !@programming_task.marked_for_destruction?
        @lesson.programming_task ||= @lesson.build_programming_task # Ensure task object exists
        # Don't assign _destroy here, just attributes for validation
        task_attrs_for_validation = programming_task_attributes.except(:_destroy)
        # If updating, include the ID
        task_attrs_for_validation[:id] = @programming_task.id if @programming_task.persisted?
        @lesson.programming_task.assign_attributes(task_attrs_for_validation)
      elsif !has_programming_task && @programming_task&.persisted?
        # No validation needed if marking for destruction
        return @lesson.valid? # Check lesson validity without task attributes
      end

      @lesson.valid?
    end

    # Add specific validations for the task if it's present and not marked for destruction
    def programming_task_validations
      return unless has_programming_task
      return if programming_task_attributes.blank? || programming_task_attributes[:_destroy] == "1" || programming_task_attributes["_destroy"] == "1"

      # Build a temporary task instance *only* for validation purposes if needed
      temp_task = @programming_task || ProgrammingTask.new
      temp_task.assign_attributes(programming_task_attributes.except(:_destroy, :id)) # Validate content, not persistence state

      return if temp_task.valid?

      temp_task.errors.messages.each do |field, messages|
        messages.each { |msg| errors.add(:"programming_task_#{field}", msg) }
      end
    end

    def handle_task_assignment
      if has_programming_task && programming_task_attributes.present?
        # Task should exist or be created
        current_task = @lesson.programming_task || @lesson.build_programming_task # Ensure task object exists
        attrs_to_save = programming_task_attributes.except(:_destroy) # Don't save _destroy flag
        # Make sure ID is included if updating an existing record identified by attributes hash
        attrs_to_save[:id] = current_task.id if current_task.persisted? && programming_task_attributes[:id].blank?
        current_task.assign_attributes(attrs_to_save)
        @lesson.programming_task = current_task # Explicitly associate if built
        # `lesson.save!` will handle saving the associated task
      elsif !has_programming_task && @lesson.programming_task.present?
        # Task should be destroyed if it exists
        @lesson.programming_task.mark_for_destruction
        # `lesson.save!` will handle destroying the associated task
      end
    end

    def lesson_model_validations
      # Assign current form values to the lesson model for validation check
      # Note: Content is already assigned in initialize/submit
      @lesson.assign_attributes(
        title: title,
        programming_course_chapter_id: programming_course_chapter_id
      )

      # Temporarily assign task attributes if the task should exist
      task_valid = true
      if has_programming_task && programming_task_attributes.present?
        temp_task = @lesson.programming_task || ProgrammingTask.new # Use existing associated or new
        temp_task.assign_attributes(programming_task_attributes.except(:_destroy, :id))
        task_valid = temp_task.valid? # Check task validity
      elsif !has_programming_task && @lesson.programming_task&.persisted?
        # If destroying, no task validation needed, just check lesson itself
      end

      # Check lesson validity (which might include associated task validity if autosave: true)
      lesson_valid = @lesson.valid?

      # Explicitly merge errors if either model is invalid
      merge_lesson_errors unless lesson_valid && task_valid
    end

    def programming_task_validations
      return unless has_programming_task
      # Don't validate attributes if they are blank OR if we are destroying
      return if programming_task_attributes.blank?
      return if programming_task_attributes[:_destroy] == "1" || programming_task_attributes["_destroy"] == "1"

      # Build a temporary task instance *only* for validating the attributes hash
      temp_task = ProgrammingTask.new(programming_task_attributes.except(:_destroy, :id))

      return if temp_task.valid?

      temp_task.errors.messages.each do |field, messages|
        attr_name = :"programming_task_#{field}"
        messages.each { |msg| errors.add(attr_name, msg) unless errors.messages.key?(attr_name) && errors.messages[attr_name].include?(msg) }
      end
    end
  end
end
