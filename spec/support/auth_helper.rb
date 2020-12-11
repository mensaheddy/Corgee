module AuthHelper
  def login(user)
    header = user.create_new_auth_token
    request.headers.merge!(header)
  end
end