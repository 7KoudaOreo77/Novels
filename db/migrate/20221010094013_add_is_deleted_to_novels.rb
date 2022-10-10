class AddIsDeletedToNovels < ActiveRecord::Migration[6.1]
  def change
    add_column :novels, :is_deleted, :boolean, default: true
  end
end
