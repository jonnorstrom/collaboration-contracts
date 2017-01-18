class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  after_filter :store_action

    def store_action #saves path before redirect to sign_in or log_in
      return unless request.get?
      if (request.path != "/users/sign_in" &&
          request.path != "/users/sign_up" &&
          request.path != "/users/password/new" &&
          request.path != "/users/password/edit" &&
          request.path != "/users/confirmation" &&
          request.path != "/users/sign_out" &&
          !request.xhr?) # don't store ajax calls
        store_location_for(:user, request.fullpath)
      end
    end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

end
