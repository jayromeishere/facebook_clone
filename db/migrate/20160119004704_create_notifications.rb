class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.string :source_id
      t.string :integer
      t.string :source_type

      t.timestamps null: false
    end
  end
end
