FactoryBot.define do
  factory :purchase_address do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code         { '111-1111' }  # 郵便番号
    shipping_area_id  { 2 }           # 配送地域のID
    municipality      { '東京都渋谷区' } # 市区町村
    street_address    { '1-2-3' }    # 番地
    building_name     { 'ビル名A101' }  # 建物名（オプション）
    phone_number      { '09012345678' } # 電話番号
  end
end
