class ChangeAcceptedDefault < ActiveRecord::Migration
  def change
    change_column :friend_requests, :accepted, :boolean, default: false
  end
end
