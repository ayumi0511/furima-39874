require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
  end

  describe '出品登録' do
    context '出品できる場合' do
      it '商品に必要な情報が存在すれば登録できる' do
        expect(@purchase_address).to be_valid
      end

      it '建物名が空でも保存できる' do
        @purchase_address.building_name = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '電話番号にハイフンがある場合、保存できないこと' do
        @purchase_address.phone_number = '090-1234-5678' # ハイフンを含む
        expect(@purchase_address).not_to be_valid
      end

      it '電話番号に英字が含まれる場合、保存できないこと' do
        @purchase_address.phone_number = '090abcdefg' # 英字を含む
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number should be 10 to 11 digits')
      end

      it '郵便番号が空だと保存できないこと' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '都道府県が空だと保存できないこと' do
        @purchase_address.shipping_area_id = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Shipping area can't be blank")
      end

      it '市区町村が空だと保存できないこと' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @purchase_address.street_address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列でない場合、保存できないこと' do
        @purchase_address.post_code = '1234567' # 良くない例
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end

      it '電話番号が10桁未満の場合、保存できないこと' do
        @purchase_address.phone_number = '123456789' # 良くない例
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number should be 10 to 11 digits',
                                                                  'Phone number should be 10 to 11 digits')
      end

      it '電話番号が11桁を超える場合、保存できないこと' do
        @purchase_address.phone_number = '123456789012' # 良くない例
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number should be 10 to 11 digits')
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
