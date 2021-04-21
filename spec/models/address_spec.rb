require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    sleep(0.1)
    @address = FactoryBot.build(:address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品を購入できるとき' do
      it '配送先の住所が正しく入力され、カード情報のtokenがあるとき' do
        expect(@address).to be_valid
      end

      it 'address2が空でも商品購入できる' do
        @address.address2 = nil
        expect(@address).to be_valid
      end
    end

    context '商品を購入できないとき' do
      it '郵便番号が空では商品購入できない' do
        @address.postal_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal number can't be blank")
      end

      it '都道府県が空では商品購入できない' do
        @address.prefecture_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県の値が１では商品購入できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture Select")
      end
      it '市区町村が空では商品購入できない' do
        @address.municipality = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'アドレス１が空では商品購入できない' do
        @address.address1 = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Address1 can't be blank")
      end

      it '電話番号が空では商品購入できない' do
        @address.phone_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '郵便番号に-がふくまれていなければ商品購入できない' do
        @address.postal_number = '1234567'
        @address.valid?
        expect(@address.errors.full_messages).to include('Postal number Input correctly')
      end

      it '電話番号が12桁以上では商品購入できない' do
        @address.phone_number = '123456789123'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it '電話番号に数値以外の値が入力されていると商品購入できない' do
        @address.phone_number = 'testテスト'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number Input only number')
      end

      it 'カード情報のtokenが空では商品購入できない' do
        @address.token = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Token can't be blank")
      end

      it 'ユーザーのidが空では商品購入できない' do
        @address.user_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("User can't be blank")
      end

      it '商品のidが空では商品購入できない' do
        @address.item_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
