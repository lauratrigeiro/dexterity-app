class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :username, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }
  validates :username, length: { minimum: 3 }, if: -> { self.username.present? }

end
