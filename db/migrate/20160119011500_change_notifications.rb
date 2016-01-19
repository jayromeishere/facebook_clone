class ChangeNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :source_id
    remove_column :notifications, :integer
  end
end
