class ResourcesController < ApplicationController
  def index
    @sigs = Item.where(type: 'Signal')
    @tags = Tag.all
    @item = Item.first
    if params[:type].present?
        @filter = params[:type] + 's'
        @items = Item.where(type: params[:type])
    else
        @filter = 'All Items'
        @items = Item.all
    end
  end
end
