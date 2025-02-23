# Base class for all database objects.
# Here’s an example of a well-structured User model:
# class User < ActiveRecord::Base
#   # Default scope (if any)
#   default_scope { where(active: true) }

#   # Constants
#   COLORS = %w(red green blue)

#   # Attribute-related macros
#   attr_accessor :formatted_date_of_birth

#   # Associations
#   belongs_to :country

#   # Validations
#   validates :email, presence: true

#   # Callbacks
#   before_save :cook

#   # Other macros (e.g., Devise)
# end
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
