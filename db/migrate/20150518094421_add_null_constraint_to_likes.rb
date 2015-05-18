class AddNullConstraintToLikes < ActiveRecord::Migration
  def change
    change_column :likes, :email, :string, null: false
    change_column :likes, :photo_id, :integer, null: false
  end
end
