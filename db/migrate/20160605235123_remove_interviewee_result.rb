class RemoveIntervieweeResult < ActiveRecord::Migration
  def change
    remove_column :interviewees, :result
  end
end
