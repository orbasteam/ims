class CreateInterviewees < ActiveRecord::Migration
  def change
    create_table :interviewees do |t|

      t.string :name, nil: false
      t.string :name_en
      t.integer :gender
      t.string :number, nil: false
      t.string :email
      t.string :phone
      t.integer :position_id
      t.text :spot
      t.string :skill
      t.datetime :interview_at
      t.string :note
      t.string :result

      t.timestamps null: false
    end
  end
end
