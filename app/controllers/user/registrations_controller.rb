class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected
    # allow the first name and last name to permitted parameters 
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end
end