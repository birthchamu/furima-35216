class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :move_to_index
  def index
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.valid?
      pay_item
      @address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_number, :prefecture_id, :municipality, :address1, :address2, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if @item.user.id == current_user.id || @item.purchase_record.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: address_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
