class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :requester_id
      t.integer :requested_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
