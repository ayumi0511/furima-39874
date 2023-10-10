class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new # Formオブジェクトのインスタンスを作成
  end


    def create
      @item = Item.find(params[:item_id])
      @purchase_address = PurchaseAddress.new(purchase_params)
  
      if @purchase_address.valid? 
        @purchase_address.save
        redirect_to root_path, notice: '購入が成功しました。'
      else
        render :index, status: :unprocessable_entity 
      end
    end
  
    private
  
    def purchase_params
      params.require(:purchase_address).permit(:post_code, :shipping_area_id, :municipality, :street_address, :building_name, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id])
    end
  end
