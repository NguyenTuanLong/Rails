class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    belongs_to :user

    def add_post(post_id)
        current_item = line_items.find_by_post_id(post_id)
        if current_item
            current_item.quantity += 1
        else
            current_item = line_items.build(post_id: post_id)
        end
        current_item
    end

    def total_price 
        line_items.to_a.sum { |item| item.total_price }
    end

    def total_cost 
        line_items.to_a.sum { |item| item.total_cost }
    end
end
