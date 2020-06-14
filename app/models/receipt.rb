class Receipt < ApplicationRecord
    belongs_to :user
    has_many :records, dependent: :destroy
    
    def total_price 
        records.to_a.sum { |item| item.total_price }
      end
    
    def total_cost 
        records.to_a.sum { |item| item.total_cost }
    end
end
