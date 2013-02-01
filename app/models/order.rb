class Order < ActiveRecord::Base
  attr_accessible :total, :user_id
end
