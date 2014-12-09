class Score < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :time, presence: true
 # default_scope -> { order('time ASC') }

  	class << self
  		def overall_best(opts = {})
      		Score.where(opts).order(:time).first
  		end
	end
end
