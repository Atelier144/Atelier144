class AddColumnNewPasswordHash < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :new_password_hash, :string
  end
end
