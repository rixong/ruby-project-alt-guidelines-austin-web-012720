class User < ActiveRecord::Base
  has_many :schedules
  has_many :events, through: :schedules

  def self.cur_user 
    User.find(1)
  end



end
