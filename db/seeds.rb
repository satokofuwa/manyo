# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  Task.create!(title: "",
    title: "task_title#{n+1}",
    content: "task_content#{n+1}",
    expired_at: "2021-12-#{rand(1..31)}",
    status: "未着手"
               )
end

5.times do |n|
  User.create!(
    name: "admin#{n+10}",
    email: "admin#{n+10}@test.com",
    password: '1234567+A', 
  )
end