class CreatePostSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :postsubs do |t|
      t.integer :sub_id
      t.integer :post_id
      t.timestamps
    end
    add_index :postsubs, [:sub_id, :post_id], unique: true
  end
end
