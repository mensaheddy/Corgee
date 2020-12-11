class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ExceptionHandlers

  protect_from_forgery with: :null_session
  before_action :authenticate_user!
end
