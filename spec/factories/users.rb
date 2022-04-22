FactoryBot.define do
  factory :user do
    id { 1 }
    name { "admin" }
    email { "admin@test.com" }
    password {'1234567+A'} 
    password_confirmation {'1234567+A'} 
    admin { "管理者" }
  end

  factory :second_user, class: User do
    id { 2 }
    name { "general" }
    email { "general@test.com" }
    password {'1234567+A'} 
    password_confirmation {'1234567+A'} 
    admin { "ユーザー" }
  end

  factory :third_user, class: User do
    id { 3 }
    name { "secondadmin" }
    email { "admin2@test.com" }
    password {'1234567+A'} 
    password_confirmation {'1234567+A'} 
    admin { "管理者" }
end

end