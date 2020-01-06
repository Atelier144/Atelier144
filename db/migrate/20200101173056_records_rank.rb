class RecordsRank < ActiveRecord::Migration[5.2]
  def change
    remove_column :infinite_blocks_records, :rank, :integer
  end
end
