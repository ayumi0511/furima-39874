require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'users_nicknameが空では登録できない' do
    @user.users_nickname = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Users nickname can't be blank")
  end

  it 'emailが空では登録できない' do
    @user.email = ''
    @user.valid?
    expect(@user.errors.full_messages).to include "Email can't be blank"
  end

  it 'emailが一意性であること' do
    @user.save
    user = FactoryBot.build(:user)
    user.email =  @user.email
    user.valid? # バリデーションを実行
    expect(user.errors.full_messages).to include 'Email has already been taken' # エラーメッセージを検証
  end

  it 'emailは@を含まないと登録できない' do
    @user.email = 'testmail'
    @user.valid?
    expect(@user.errors.full_messages).to include('Email is invalid')
  end

  it 'passwordが空では登録できない' do
    @user.password = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end

  it 'password_confirmationが空では登録できない' do
    @user.password_confirmation = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it 'first_nameが空では登録できない' do
    @user.first_name = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
  end

  it 'last_nameが空では登録できない' do
    @user.last_name = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
  end

  it 'first_name_kanaが空では登録できない' do
    @user.first_name_kana = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
  end

  it 'last_name_kanaが空では登録できない' do
    @user.last_name_kana = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid')
  end

  it 'birthdayが空では登録できない' do
    @user.birthday = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Birthday can't be blank")
  end

  it 'passwordが5文字以下では登録できない' do
    @user.password = '00000'
    @user.password_confirmation = '00000'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
  end

  it 'passwordとpassword_confirmationが不一致では登録できない' do
    @user.password = '123456'
    @user.password_confirmation = '1234567'
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it 'first_nameとlast_nameが全角であれば登録できる' do
    @user.first_name = '桐生'
    @user.last_name = 'ココ'
    expect(@user).to be_valid
  end

  it 'first_name_kanaとlast_name_kanaが全角であれば登録できる' do
    @user.first_name_kana = 'イオフィ'
    @user.last_name_kana = 'イナニス'
    expect(@user).to be_valid
  end

  it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
    @user.password = 'test1234'
    @user.password_confirmation = 'test1234'
    expect(@user).to be_valid
  end

  it 'passwordが存在してもpassword_confirmationが空では登録できない' do
    @user.password_confirmation = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it 'passwordが数字だけだと登録できない' do
    @user.password = '11111111'
    @user.password_confirmation = '11111111'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
  end

  it 'passwordが英字だけだと登録できない' do
    @user.password = 'aaaaaaaa'
    @user.password_confirmation = 'aaaaaaaa'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
  end

  it 'passwordが全角だと登録できない' do
    @user.password = 'ああああああ'
    @user.password_confirmation = 'ああああああ'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
  end

  it 'passwordが英数字混合でも6文字未満なら登録できない' do
    @user.password = 'test1'
    @user.password_confirmation = 'test1'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
  end

  it 'passwordが半角英数字混合であること' do
    # パスワードを半角英字のみで設定
    @user.password = 'password'
    @user.valid?
    expect(@user.errors[:password]).to include('には英字と数字の両方を含めて設定してください')
  end

  it 'first_nameが全角（漢字・ひらがな・カタカナ）であること' do
    # お名前(全角)に全角文字（漢字、ひらがな、カタカナ）のみを含む場合
    @user.first_name = 'tarou'
    @user.last_name = 'tarou'
    @user.valid?
    expect(@user.errors.full_messages).to include('First name is invalid')
  end

  it 'first_nameが全角（カタカナ）であること' do
    # お名前(全角)に全角文字（カタカナ）のみを含む場合
    @user.first_name = 'tarou'
    @user.last_name = 'tarou'
    @user.valid?
    expect(@user.errors.full_messages).to include('First name is invalid')
  end
end
