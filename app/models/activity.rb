class Activity < ActiveRecord::Base

  belongs_to :interviewee

  def self.group_count(interviewees)
    group(:interviewee_id).where(interviewee_id: interviewees.collect(&:id)).count
  end

end
