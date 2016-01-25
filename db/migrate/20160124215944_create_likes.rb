class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :liker_id
      t.integer :likeable_id
      t.string :likeable_type

      t.timestamps null: false
    end
  end
end
