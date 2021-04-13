class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname         , presence: true
  validates :password         , presence: true, format: { with: /\A[a-zA-Z0-9]+\z/},  length: { minimum: 6 }
  validates :first_name       , presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :family_name      , presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name_kana  , presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :family_name_kana , presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :date_of_birth    , presence: true
end
