class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|
      t.string :title, null: false
      t.text :caption
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
