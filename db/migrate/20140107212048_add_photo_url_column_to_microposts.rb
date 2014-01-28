class AddPhotoUrlColumnToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :pic_url, :string
  end
end
