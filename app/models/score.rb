class Score < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :time, presence: true
 # default_scope -> { order('time ASC') }
end
