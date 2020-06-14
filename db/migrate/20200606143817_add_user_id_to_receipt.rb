class AddUserIdToReceipt < ActiveRecord::Migration[6.0]
  def change
    add_column :receipts, :user_id, :integer
    add_column :records, :receipt_id, :integer
  end
end
