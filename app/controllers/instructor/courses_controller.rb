module Instructor
  # Controller for managing courses as instructor
  class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_instructor!

    def new; end
  end
end
