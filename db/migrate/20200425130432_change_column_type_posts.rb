class ChangeColumnTypePosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :image, :mediumblob, null: true
  end
end
