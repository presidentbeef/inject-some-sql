class User < ActiveRecord::Base
  attr_accessible :admin, :name, :password
end
