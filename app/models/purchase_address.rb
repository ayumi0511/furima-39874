class PurchaseAddress 

    include ActiveModel::Model
    attr_accessor :post_code, :shipping_area_id, :municipality, :street_address, :building_name, :phone_number, :buy_record, :item_id, :user_id
    #attr_accessor :hoge, :fuga
    # バリデーションの処理を記述します
    validates_presence_of :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  
    def save
      # 寄付情報を保存し、変数donationに代入する
      buy_record = BuyRecord.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Address.create(post_code: post_code, shipping_area_id: shipping_area_id, municipality: municipality, street_address: street_address, building_name: building_name, buy_record_id: buy_record.id,phone_number: phone_number)
      # 各テーブルにデータを保存する処理を記述します
      # このメソッドをカスタマイズして、データの保存処理を実装します
      # たとえば、データベースに保存する場合は、ActiveRecordを使用します
    end
  end
