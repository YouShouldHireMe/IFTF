class ResourcesController < ApplicationController
   def index
    @sigs = Item.where(type: 'Signal')
    query = Tag.all(:tags).items.query_as(:tagitems)
    @tags = query.with(:tags, 'count(tagitems) AS count').order('count DESC').limit(5).pluck(:tags)
    @item = Item.first
    @taggings = ''
    @selectTags = []
    if params[:type].present? && params[:type] != "Item"
        @filter = params[:type] + 's'
        if params[:tag].present?
            @tag = Tag.find(params[:tag])
            @items = @tag.items.where(type: params[:type])
            @taggings = 'tagged with "' + @tag.name + '"'
        else
            @items = Item.where(type: params[:type])
        end
    else
        @filter = 'All Items'
        if params[:tag].present?
            @tag = Tag.find(params[:tag])
            @items = Item.where('result_item.uuid IN {items}', items: @tag.items.map { |i| i.id })
            @taggings = 'tagged with "' + @tag.name + '"'
        else
            @items = Item.all
        end
    end
    # Pagination
    @items = @items.page(params[:page]).per(5)
  end
end
