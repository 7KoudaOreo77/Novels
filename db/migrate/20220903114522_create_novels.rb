class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|
      t.string :title, null: false
      t.text :body, null: false

      t.text :caption

      t.integer :user_id, null: false

      t.integer :tag_id
      t.integer :favorite_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
