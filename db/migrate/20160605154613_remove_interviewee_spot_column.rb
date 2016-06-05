class RemoveIntervieweeSpotColumn < ActiveRecord::Migration

  def up
    remove_column :interviewees, :spot
    remove_column :interviewees, :skill
    remove_column :interviewees, :name_en
  end

  def down
    add_column :interviewees, :spot, :text
    add_column :interviewees, :skill, :string
    add_column :interviewees, :name_en, :string
  end

end
