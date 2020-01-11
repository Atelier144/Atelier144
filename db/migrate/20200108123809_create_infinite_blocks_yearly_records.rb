class CreateInfiniteBlocksYearlyRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :infinite_blocks_yearly_records do |t|
      t.integer :user_id
      t.integer :score
      t.integer :level

      t.timestamps
    end
  end
end
