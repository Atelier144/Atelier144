class UserMigration20191204 < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_certificated, :string
    remove_column :users, :new_email, :string
    add_column :users, :introduction, :string
    add_column :users, :web_site, :string
    add_column :users, :twitter_provider, :string
    add_column :users, :twitter_uid, :string
  end
end
