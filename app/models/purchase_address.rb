class PurchaseAddress 

    include ActiveModel::Model
    attr_accessor :post_code, :shipping_area_id, :municipality, :street_address, :building_name, :phone_number, :buy_record, :item_id, :user_id, :reuse_existing_address
    
    # バリデーションの処理を記述します
    with_options presence: true do
    validates_presence_of :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :shipping_area_id
    validates :municipality
    validates :street_address
    validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "should be 10 to 11 digits" }
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
  
    validates :user_id
    validates :item_id
  # building_name フィールドに allow_nil: true を指定し、他のバリデーションルールも指定
    end

  #def address_reuse_validation
    # もし新しい住所を入力する必要がある場合、他のバリデーションを実行
    # 例: バリデーションルールを追加
    #if some_condition
    #errors.add(:some_field, "is invalid") if some_condition
    #end
  #end



    #def save
      # 寄付情報を保存し、変数donationに代入する
      #buy_record = BuyRecord.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    #Address.create(post_code: post_code, shipping_area_id: shipping_area_id, municipality: municipality, street_address: street_address, building_name: building_name, buy_record_id: buy_record.id,phone_number: phone_number)
      # 各テーブルにデータを保存する処理を記述します
      # このメソッドをカスタマイズして、データの保存処理を実装します
      # たとえば、データベースに保存する場合は、ActiveRecordを使用します
    #end
  #end

  def save
    # 寄付情報を保存し、変数donationに代入する
    purchaseaddress = PurchaseAddress.create(price: price, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Address.create(post_code: post_code, shipping_area_id: shipping_area_id, municipality: municipality, street_address: street_address, building_name: building_name, buy_record_id: buy_record_id, phone_number: phone_number, address_id: address.id)
    
  end
end