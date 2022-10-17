class CreateNovelTags < ActiveRecord::Migration[6.1]
  def change
    create_table :novel_tags do |t|
      t.references :novel, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :novel_tags, [:novel_id, :tag_id]
  end
end
