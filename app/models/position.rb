class Position < ActiveRecord::Base

  validates :name, presence: true

  has_many :interviewees

end
