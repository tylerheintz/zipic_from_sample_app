class ChangeDefaultForMicropostRating < ActiveRecord::Migration
  def change
  	change_column :microposts, :rating, :integer, :default => 0
  end
end
