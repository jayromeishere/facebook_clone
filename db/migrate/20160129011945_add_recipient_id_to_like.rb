class AddRecipientIdToLike < ActiveRecord::Migration
  def change
    add_column :likes, :recipient_id, :integer
  end
end
