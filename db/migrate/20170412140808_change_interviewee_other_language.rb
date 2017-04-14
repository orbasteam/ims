class ChangeIntervieweeOtherLanguage < ActiveRecord::Migration
  def up
    remove_column :interviewees, :other_language
    add_column :interviewees, :other_language_familiar, :string
    add_column :interviewees, :other_language_unfamiliar, :string
  end

  def down
    add_column :interviewees, :other_language, :string
    remove_column :interviewees, :other_language_familiar
    remove_column :interviewees, :other_language_unfamiliar
  end

end
