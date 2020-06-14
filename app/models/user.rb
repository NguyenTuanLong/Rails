class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  has_many :carts
  has_many :receipts
  # has_many :records
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def total_price 
    receipts.to_a.sum { |item| item.total_price }
  end

  def total_cost 
    receipts.to_a.sum { |item| item.total_cost }
  end
end