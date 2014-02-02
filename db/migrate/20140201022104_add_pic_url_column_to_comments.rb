class AddPicUrlColumnToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :pic_url, :string
  end
end
