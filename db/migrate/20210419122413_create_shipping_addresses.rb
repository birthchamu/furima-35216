class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string     :postal_number,   null:false
      t.integer    :prefecture_id,   null:false
      t.string     :municipality,    null:false
      t.string     :address1,        null:false
      t.string     :address2
      t.string     :phone_number,    null:false, unique: true
      t.references :purchase_record, null:false, foreign_key: true
      t.timestamps
    end
  end
end
