class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :referer_id
      t.integer :referee_id

      t.timestamps null: false
    end
  end
end
