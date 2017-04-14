class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.belongs_to :interviewee
      t.string :name
      t.string :title
      t.string :period
      t.string :seniority
      t.integer :salary
      t.string :reason
      t.timestamp null: false
    end
  end
end
