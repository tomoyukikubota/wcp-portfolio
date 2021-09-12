class AddIsDeleteToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_delete, :boolean, default: false, null: false
  end
end
