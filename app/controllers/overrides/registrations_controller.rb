module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_before_action :authenticate_user!, only: [:create]

    before_action :configure_permitted_parameters

    def render_create_success
      render json: @resource, serializer: UserSerializer, status: :ok
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:first_name, :last_name]
    end
  end
end