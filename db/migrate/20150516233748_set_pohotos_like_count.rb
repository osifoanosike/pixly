class SetPohotosLikeCount < ActiveRecord::Migration
  def change
    change_column :photos, :like_count, :integer, default: 0
  end
end
