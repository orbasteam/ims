class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :recoverable
end
