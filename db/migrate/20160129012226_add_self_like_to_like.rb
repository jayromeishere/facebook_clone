class AddSelfLikeToLike < ActiveRecord::Migration
  def change
    add_column :likes, :self_like, :boolean, default: false
  end
end
