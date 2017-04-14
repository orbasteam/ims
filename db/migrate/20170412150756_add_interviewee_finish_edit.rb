class AddIntervieweeFinishEdit < ActiveRecord::Migration
  def change
    add_column :interviewees, :finish_edit, :boolean, default: false
  end
end
