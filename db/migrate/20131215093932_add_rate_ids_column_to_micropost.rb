class AddRateIdsColumnToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :rate_ids, :integer
  end
end
