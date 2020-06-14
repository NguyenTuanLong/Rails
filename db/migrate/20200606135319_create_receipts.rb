class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|

      t.timestamps
    end
  end
end
