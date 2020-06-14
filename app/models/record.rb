class Record < ApplicationRecord
    belongs_to :receipt
    # belongs_to :user
    validates :title, uniqueness: {scope: :receipt_id}
    has_one_attached :image

    def total_price
        self.price * quantity
    end

    def total_cost
        self.cost * quantity
    end
end
