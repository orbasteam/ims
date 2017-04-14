class AddIntervieweeRelativeColumn < ActiveRecord::Migration
  def change
    add_column :interviewees, :relatives, :string
  end
end
