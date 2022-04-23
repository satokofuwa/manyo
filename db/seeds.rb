
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: "管理者")

10.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@rails.org"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    admin: "ユーザー")
end

10.times do |num|
  Label.create!(label_name:"label#{num}")
end
#5.times do |n|
 # User.create!(
  #  name: "admin#{n+10}",
   # email: "admin#{n+10}@test.com",
    #password: '1234567+A', 
    #admin: true)
 # )
#end