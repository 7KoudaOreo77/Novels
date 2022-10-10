class CreateNovelBodies < ActiveRecord::Migration[6.1]
  def change
    create_table :novel_bodies do |t|
      t.text :body
      t.references :novel, null: false, foreign_key: true
      t.string :subtitle
      t.integer :position, null: false

      t.timestamps
    end
  end
end
