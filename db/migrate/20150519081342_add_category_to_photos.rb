class AddCategoryToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :category_id, :integer, default: 3
  end
end
