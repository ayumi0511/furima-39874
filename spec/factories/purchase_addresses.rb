FactoryBot.define do
  factory :purchase_address do

    post_code         { '111-1111' }  # 郵便番号
    shipping_area_id  { 1 }           # 配送地域のID
    municipality      { '東京都渋谷区' } # 市区町村
    street_address    { '1-2-3' }    # 番地
    building_name     { 'ビル名A101' }  # 建物名（オプション）
    phone_number      { '09012345678' } # 電話番号
    association :buy_record, factory: :buy_record # 関連する購入レコード
    
  end
end
