class User < ApplicationRecord
  has_many :buy_records
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :users_nickname, :email, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday,
            presence: true
  has_many :items
  has_many :buy_records

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  validates :first_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ },
            presence: true

  validates :last_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ },
            presence: true

  validates :first_name_kana,
            format: { with: /\A([ァ-ン]|ー)+\z/ },
            presence: true
  validates :last_name_kana,
            format: { with: /\A([ァ-ン]|ー)+\z/ },
            presence: true
end
