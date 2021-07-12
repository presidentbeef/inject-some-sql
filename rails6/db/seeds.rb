# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Bob", "Jim", "Sarah", "Tina", "Tony"].each do |name|
  User.create :name => name, :password => "#{name}pass", :admin => false, :age => (rand(60) + 18)
end

User.create :name => "Admin", :password => "supersecretpass", :admin => true, :age => (rand(60) + 18)

first_user_id = User.first.id

Order.create :user_id => first_user_id, :total => 10
Order.create :user_id => (first_user_id + 1), :total => 500
Order.create :user_id => (first_user_id + 3), :total => 1
