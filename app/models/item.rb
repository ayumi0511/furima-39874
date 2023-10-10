class Item < ApplicationRecord
  belongs_to :user
  has_one :buy_record
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :situation
  belongs_to :shipping_charge
  belongs_to :shipping_area
  belongs_to :shipping_date

  # has_one :buy_record, dependent: :destroy
  has_one_attached :image
  validates :image, :name, :concept, :category, :situation, :shipping_charge, :shipping_area, :shipping_date, :price,
            presence: true

  validates :category_id, :situation_id, :shipping_charge_id, :shipping_area_id, :shipping_date_id,
            numericality: { other_than: 1 }

  validates :price, presence: true,
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9_999_999
                    }
end
