class User < ActiveRecord::Base
  has_many :schedules
  has_many :events, through: :schedules
end
