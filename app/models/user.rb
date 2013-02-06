class User < ActiveRecord::Base
  attr_accessible :admin, :name, :password, :age
  has_many :orders
end
