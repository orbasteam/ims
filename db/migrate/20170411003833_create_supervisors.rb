class CreateSupervisors < ActiveRecord::Migration
  def change
    create_table :supervisors do |t|
      t.string :name
      t.string :department
      t.string :title
      t.string :phone
      t.string :contact_time
      t.timestamps null: false
    end
  end
end
