class Addcolumn20191231 < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_published_web_site, :boolean
    add_column :users, :is_published_profile, :boolean
    add_column :users, :is_published_url, :boolean
    add_column :users, :is_published_records, :boolean
  end
end
