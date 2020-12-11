FactoryBot.define do
  factory :user do
    first_name { "bright" }
    last_name { "mensah" }
    email { "bright@gmail.com"}
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end