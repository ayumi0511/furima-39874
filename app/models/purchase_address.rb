class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :shipping_area_id, :municipality, :street_address, :building_name, :phone_number, :buy_record,
                :item_id, :user_id, :reuse_existing_address, :token

  validates :shipping_area_id, numericality: { other_than: 1, message: "can't be blank" }
  with_options presence: true do
    validates :municipality
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'should be 10 to 11 digits' }
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    buy_record = BuyRecord.create(item_id:, user_id:)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Address.create(post_code: post_code, shipping_area_id: shipping_area_id, municipality: municipality,
                   street_address: street_address, building_name: building_name, buy_record_id: buy_record.id, phone_number: phone_number)
  end
end
