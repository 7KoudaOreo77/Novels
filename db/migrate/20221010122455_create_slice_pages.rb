class CreateSlicePages < ActiveRecord::Migration[6.1]
  def change
    create_table :slice_pages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :novel, null: false, foreign_key: true
      t.text :url

      t.timestamps
      t.index [:user_id, :novel_id], unique: true
    end
  end
end
