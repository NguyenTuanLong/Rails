class AddPriceToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :price, :decimal, :precision => 8, :scale => 2
    add_column :posts, :cost, :decimal, :precision => 8, :scale => 2
    add_column :posts, :quantity, :decimal
  end
end
