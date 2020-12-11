module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    skip_before_action :authenticate_user!, only: [:create, :destroy]
  end
end