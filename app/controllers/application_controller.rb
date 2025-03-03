# Base class for all controllers.
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_instructor!
    redirect_to root_path, alert: t("controllers.alerts.must_be_instructor") unless current_user&.instructor?
  end
end
