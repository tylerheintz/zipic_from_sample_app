class ChangeDefaultForMicropostRating < ActiveRecord::Migration
  def change
  	change_column :microposts, :rating, :integer, :default => 50
  end
end
