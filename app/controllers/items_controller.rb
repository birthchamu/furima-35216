class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :upadate]
  bwfore_action :find_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @items = Item.all
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(items_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def items_params
    params.require(:item).permit(:image, :name, :text, :category_id, :product_condition_id, :shipping_charge_id, :prefecture_id,
                                 :estimated_shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @item.user.id == current_user.id
  end
end
