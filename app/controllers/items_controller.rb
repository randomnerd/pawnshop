class ItemsController < ApplicationController
  def index
    @items = Item.not_declined
    @items = @items.title_search params[:query] if params[:query].present?
  end

  def create
    Item.create params[:item].permit :email, :title, :image
    redirect_to items_path
  end
end
