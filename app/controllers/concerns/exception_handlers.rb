module ExceptionHandlers
  extend ActiveSupport::Concern

  class UnauthorizedAccess < StandardError; end

  included do
    rescue_from UnauthorizedAccess do |e|
      render json: { message: e.message }, status: :unauthorized
    end
  end
end