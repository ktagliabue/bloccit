class AddRank < ActiveRecord::Migration
  def change
    add_column :posts, :rank, :integer
    add_index :posts, :rank
  end
end
