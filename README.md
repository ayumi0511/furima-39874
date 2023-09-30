# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | --------------------------|
| users_nickname     | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| date               | string | null: false               |
| seller             | string | null: false              |

### Association

- has_many :goods
- has_many :buy_records

## goods テーブル

| Column             | Type     | Options                  |
| -------------------| -------- | -------------------------|
| goods_name         | string   | null: false              |
| price              | integer  | null: false              |
| category_id        | integer  | null: false              |
| situation          | integer  | null: false              |
| shipping charge    | integer  | null: false              |
| shipping area      | integer  | null: false              |
| shipping date      | integer  | null: false              |

### Association

- belongs_to :user
- has_one :buy_record

## address テーブル

| Column             | Type    | Options                  |
| -------------------| --------| -------------------------|
| post_code          | string  | null: false              |
| prefectures        | string  | null: false              |
| municipality       | string  | null: false              |
| street_address     | string  | null: false              |
| building_name      | string  |              |
| phone_number       | string  | null: false              |
| buy_record         | string  | null: false              |


### Association
- has_one :buy_record

## buy_records テーブル

| Column             | Type    | Options                  |
| -------------------| --------| -------------------------|
| buyer              | string  | null: false              |
| goods              | string  | null: false              |

### Association
- belongs_to :user