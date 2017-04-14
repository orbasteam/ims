class ModifyIntervieweeDiseaseType < ActiveRecord::Migration
  def up
    change_column :interviewees, :genetic_disease_note, :string
    change_column :interviewees, :nociceptive_disease_note, :string
    change_column :interviewees, :other_disease_note, :string
  end

  def down
    change_column :interviewees, :genetic_disease_note, :boolean
    change_column :interviewees, :nociceptive_disease_note, :boolean
    change_column :interviewees, :other_disease_note, :boolean
  end
end
