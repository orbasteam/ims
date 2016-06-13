class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :recoverable

  validates_confirmation_of :password

  has_many :interviewees

end
