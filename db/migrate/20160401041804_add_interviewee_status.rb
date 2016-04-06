class AddIntervieweeStatus < ActiveRecord::Migration
  def change
    add_column :interviewees, :status, :integer
  end
end
