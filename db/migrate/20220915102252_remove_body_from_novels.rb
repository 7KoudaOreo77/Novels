class RemoveBodyFromNovels < ActiveRecord::Migration[6.1]
  def change
    remove_column :novels, :body, :text, null: false
  end
end
