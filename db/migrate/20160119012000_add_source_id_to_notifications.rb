class AddSourceIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :source_id, :integer
  end
end
