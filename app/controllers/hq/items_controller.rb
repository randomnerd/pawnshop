class Hq::ItemsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @items = Item.all.order('status')
    @items = @items.title_search params[:query] if params[:query].present?
  end

  def decline
    Item.find(params[:id]).decline!
    redirect_to hq_items_path
  end

  def edit
    @item = Item.find params[:id]
  end

  def update
    item = Item.find params[:id]
    item.update_attributes params[:item].permit :email, :title, :price, :image, :status
    redirect_to hq_items_path
  end
end
