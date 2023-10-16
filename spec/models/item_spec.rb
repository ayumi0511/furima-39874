require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品登録' do
    context '出品できる場合' do
      it '商品に必要な情報が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
  end

  context '新規登録できない場合' do
    it '商品名が必須であること' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '画像ファイルが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品の説明やコンセプトが必須であること' do
      @item.concept = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Concept can't be blank")
    end

    it '商品の状態が選択されていること' do
      @item.situation_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Situation can't be blank")
    end

    it '発送料金が選択されていること' do
      @item.shipping_charge_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
    end

    it '発送元の地域が選択されていること' do
      @item.shipping_area_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping area can't be blank")
    end

    it '発送日程が選択されていること' do
      @item.shipping_date_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping date can't be blank")
    end

    it '価格が入力されていること' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it 'カテゴリーが1以外であること' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '商品の状態が1以外であること' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '配送料の負担が1以外であること' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '発送元の地域が1以外であること' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '発送までの日数が1以外であること' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '価格が小数点以下を持たない整数であること' do
      @item.price = '1000.5'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be an integer', 'Price must be an integer')
    end

    it '価格が300以上であること' do
      @item.price = '299'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が9,999,999以下であること' do
      @item.price = '10000000'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it 'userが紐付いていなければ出品できない' do
      @item = Item.new(name: 'Example Item', concept: 'This is a sample concept.', price: 1000)
      expect(@item).to_not be_valid
      expect(@item.errors[:user]).to include('must exist')
    end
  end
end
