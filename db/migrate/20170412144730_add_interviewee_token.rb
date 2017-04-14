class AddIntervieweeToken < ActiveRecord::Migration
  def change
    add_column :interviewees, :token, :string
  end
end
