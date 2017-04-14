class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.belongs_to :interviewee
      t.string :title
      t.string :name
      t.string :job
      t.timestamps null: false
    end
  end
end
