class CreateNovelComments < ActiveRecord::Migration[6.1]
  def change
    create_table :novel_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :novel_id

      t.timestamps
    end
  end
end
