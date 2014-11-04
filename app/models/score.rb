class Score < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order('time DESC') }
end
