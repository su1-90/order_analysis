class ItemsController < ApplicationController
  before_action :ensure_correct_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order(id: :desc)
    @informations = Information.all.order(id: :desc) 
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy!
    redirect_to items_path, notice: 'Item was successfully destroyed.'
  end

  private

  def item_params
    params.require(:item).permit(:product_code, :name, :order_date, :order_quantity)
  end

def ensure_correct_admin
  unless current_user.admin?
    redirect_to root_path, notice: 'You are not authorized to access this page.'
  end
end

  def set_item
    @item = Item.find(params[:id])
  end
end
