class CreateViewings < ActiveRecord::Migration
  def change
    create_table :viewings do |t|
      t.integer :user_id
      t.integer :micropost_id
      t.integer :visited_count

      t.timestamps
    end
  end
end
