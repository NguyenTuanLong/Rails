class Post < ApplicationRecord
    belongs_to :user
    before_destroy :check_if_has_line_item
    validate :check_if_price_and_cost
    validates :title, :body, :price, :cost, :quantity, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 1000}
    validates :cost, numericality: {greater_than_or_equal_to: 1000}
    validates :quantity, numericality: {greater_than_or_equal_to: 0}
    validates :title, uniqueness: {scope: :user_id}
    has_many :line_items, dependent: :destroy
    has_one_attached :image, dependent: false
  
    def self.search(search)
        if search
            where('body LIKE ? OR title LIKE ?', "%#{search}%", "%#{search}%")
        else
            all
        end
    end

private
    def check_if_has_line_item
        if line_items.any?
            errors.add(:base, 'This product has a LineItem')
            throw(:abort)
        end
    end

    def check_if_price_and_cost
        errors.add(:cost, "cost can't be larger than price") unless price > cost
    end
end
