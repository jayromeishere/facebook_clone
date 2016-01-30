class AddSelfCommentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :self_comment, :boolean, default: false
  end
end
