class AddIntervieweeContactTime < ActiveRecord::Migration
  def change
    add_column :interviewees, :contact_method, :string
  end
end
