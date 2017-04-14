class ModifyIntervieweeData < ActiveRecord::Migration
  def change

    change_table :interviewees do |t|
      t.string :name_en
      t.date    :birthday
      t.string  :native_place
      t.string  :id_number
      t.string  :blood_type
      t.string  :communicate_address
      t.string  :communicate_phone
      t.string  :residence_address
      t.string  :residence_phone
      t.boolean :over_time
      t.boolean :marriage
      t.integer :military
      t.boolean :health
      t.boolean :genetic_disease
      t.boolean :genetic_disease_note
      t.boolean :nociceptive_disease
      t.boolean :nociceptive_disease_note
      t.boolean :other_disease
      t.boolean :other_disease_note
      t.string  :expertise
      t.string  :hobby
      t.integer :chinese
      t.integer :taiwanese
      t.integer :hakka
      t.integer :english
      t.integer :japanese
      t.string  :other_language
      t.date    :onboard_date
      t.integer :wish_salary
    end

    remove_columns :interviewees, :contact_method, :interviewer_id

  end
end
