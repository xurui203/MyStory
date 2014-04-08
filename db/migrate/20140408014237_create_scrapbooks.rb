class CreateScrapbooks < ActiveRecord::Migration
  def change
    create_table :scrapbooks do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :scrapbooks, :user_id
  end
end
