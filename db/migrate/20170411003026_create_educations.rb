class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.belongs_to :interviewee
      t.string :name
      t.string :department
      t.boolean :graduated
      t.integer :school_type
      t.timestamp null: false
    end
  end
end
