class AddIntervieweeResume < ActiveRecord::Migration
  def change
    add_column :interviewees, :resume, :string
  end
end
