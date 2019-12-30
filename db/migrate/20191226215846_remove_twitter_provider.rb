class RemoveTwitterProvider < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :twitter_provider, :string
  end
end
