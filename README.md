# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| name               | string | null:false, unique: true |
| email              | string | null:false               |
| encrypted_password | string | null:false               |
| first_name         | string | null:false               |
| family_name        | string | null:false               |
| first_name_kana    | string | null:false               |
| family_name_kana   | string | null:false               |
| date_of_birth      | date   | null:false               |

### Association

- has_many :items
- has_many :purchase_records

## items テーブル

| Column                  | Type       | Options                        |
| ----------------------- | ---------- | ------------------------------ |
| user                    | references | null: false, foreign_key: true |
| name                    | string     | null:false                     |
| text                    | text       | null:false                     |
| category                | string     | null:false                     |
| product_condition       | string     | null:false                     |
| shipping_charge         | integer    | null:false                     |
| delivery_source_area    | string     | null:false                     |
| estimated_shipping_date | string     | null:false                     |
| price                   | integer    | null:false                     |

### Association

- belongs_to :user
- has_one : purchase_record

## purchase_records テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| items  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column        | Type    | Options                  |
| ------------- | ------- | ------------------------ |
| postal_number | integer | null:false               |
| prefectures   | string  | null:false               |
| municipality  | string  | null:false               |
| address1      | string  | null:false               |
| address2      | string  | null:false               |
| phone_number  | string  | null:false, unique: true |

### Association

- has_one :purchase_record




