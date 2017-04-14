class AddSupervisorIntervieweeId < ActiveRecord::Migration
  def change
    add_column :supervisors, :interviewee_id, :integer
  end
end
