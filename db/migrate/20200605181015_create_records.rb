class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :price
      t.integer :cost
      t.integer :quantity

      t.timestamps
    end
  end
end
