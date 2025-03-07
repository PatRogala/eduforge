# Base class for all controllers.
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_instructor!
    return if current_user&.instructor?

    redirect_to root_path, alert: t("controllers.alerts.must_be_instructor"),
                           status: :forbidden
  end
end
