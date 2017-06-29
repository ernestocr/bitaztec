class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
  prepend_before_action :configure_permitted_parameters

  private

    def check_captcha
      # if it is not valid, check for other errors and render :new
      unless verify_recaptcha(model: resource)
        self.resource = resource_class.new sign_up_params
        resource.validate # look for other validation errors
        respond_with_navigational(resource) { render :new }
      end
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:agreed_to_terms, :email, :password, :password_confirmation)
      end
    end

end
