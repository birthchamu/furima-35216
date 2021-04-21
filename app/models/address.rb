class Address
  include ActiveModel::Model
  attr_accessor :postal_number, :prefecture_id, :municipality, :address1, :address2, :phone_number, :purchase_record_id,
                :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_number
    validates :prefecture_id
    validates :municipality
    validates :address1
    validates :phone_number
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :postal_number, format: { with: /\A\d{3}-\d{4}\z/, message: 'Input correctly' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
  validates :phone_number, numericality: { only_integer: true, message: 'Input only number' }
  validates :phone_number, length: { maximum: 11 }

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_number: postal_number, prefecture_id: prefecture_id, municipality: municipality,
                           address1: address1, address2: address2, phone_number: phone_number, purchase_record_id: purchase_record.id)
  end
end
