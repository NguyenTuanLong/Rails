class ChangeToPost < ActiveRecord::Migration[6.0]
  def up
    change_column :posts, :quantity, :integer
    change_column :posts, :price, :integer
    change_column :posts, :cost, :integer
  end
  
  def down
    change_column :posts, :quantity, :decimal
    change_column :posts, :price, :decimal
    change_column :posts, :cost, :decimal
  end
end
