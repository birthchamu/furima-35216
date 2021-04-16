class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :name
    validates :text
    validates :price

    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :category_id
      validates :product_condition_id
      validates :shipping_charge_id
      validates :prefecture_id
      validates :estimated_shipping_date_id
    end
  end

  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }

  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :estimated_shipping_date
end
