FactoryBot.define do
  factory :user do
    name { "admin" }
    email { "admin@test.com" }
    password {'1234567+A'} 
    password_confirmation {'1234567+A'} 
    admin { "管理者" }
  end

  factory :second_user, class: User do
    name { "general" }
    email { "general@test.com" }
    password {'1234567+A'} 
    password_confirmation {'1234567+A'} 
    admin { "ユーザー" }
  end
end