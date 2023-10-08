class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit]
  
  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
    @item
  end

  def edit
    if user_signed_in? && (@item.user == current_user)
      render :edit
    else
      redirect_to root_path, alert: '商品情報の編集は許可されていません。'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item, notice: '商品情報が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :concept, :price, :category_id, :situation_id, :shipping_charge_id, :shipping_area_id,
                                 :shipping_date_id, :image).merge(user_id: current_user.id)
  end
end
