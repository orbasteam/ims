class AddIntervieweeUserId < ActiveRecord::Migration
  def change
    add_column :interviewees, :interviewer_id, :integer
  end
end
