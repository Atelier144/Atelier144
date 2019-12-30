class Migrate20191228 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_url, :string
    add_column :users, :is_published_introduction, :boolean
    add_column :users, :is_published_web_site, :boolean
    add_column :users, :is_published_twitter_url, :boolean
  end
end
