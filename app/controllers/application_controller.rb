# Base class for all controllers.
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def authenticate_instructor!
    return if current_user&.instructor?

    redirect_to root_path, alert: t("controllers.alerts.must_be_instructor"),
                           status: :forbidden
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end
