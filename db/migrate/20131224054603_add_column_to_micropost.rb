class AddColumnToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :tags, :string
  end
end
