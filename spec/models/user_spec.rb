require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'userに関する情報がすべて存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passswordが５文字以下では登録できない' do
        @user.password = '1Test'
        @user.password_confirmation = '1Test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合でなければ登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordとpassword_confirmationが一致していなければ登録できない' do
        @user.password = '12Test'
        @user.password_confirmation = '99Test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", 'Family name is invalid')
      end

      it 'family_nameが全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.family_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
      end

      it 'first_name_kanaが全角(カタカナ）でなければ登録できない' do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", 'Family name kana is invalid')
      end

      it 'family_name_kanaが全角(カタカナ）でなければ登録できない' do
        @user.family_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana is invalid')
      end

      it 'date_of_birthが空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
