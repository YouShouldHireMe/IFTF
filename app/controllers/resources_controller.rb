class ResourcesController < ApplicationController
   def index
    #for simple filters
    @projects = Item.where(type: 'Project')
    query = Tag.all(:tags).items.query_as(:tagitems)
    @tags = query.with(:tags, 'count(tagitems) AS count').order('count DESC').limit(4).pluck(:tags)
    
    #for advanced filters
    @taggings = ''
    @filter = 'All Items'
    @related_project = ''
    @selectTags = []
    @search
    
    @item = Item.first
    @items = Item.all

    # Filters
    if params[:project].present?
        @project = Item.find(params[:project])
        @items = @items.where(type: 'Signal')
        @related_project = ' related to "' + @project.title + '"'
    end
            
    if params[:type].present? && params[:type] != "Item"
        @filter = params[:type] + 's'
        @items = @items.where(type:params[:type])
    end 

    if params[:tag].present?
        @tag = Tag.find(params[:tag])
        @items = @items.where('n.uuid IN {items}', items: @tag.items.map { |i| i.id })
        @taggings = ' tagged with "' + @tag.name + '"'
    end
    
    if params[:search].present?
         @items = @items.where(title: /.*#{Regexp.escape(params[:search])}.*/)
         @search = 'Search Result for "' + params[:search] + '"'
    end

    # Pagination
    @items = @items.page(params[:page]).per(5)

    respond_to do |format|
        format.html {}
        format.js {}
        format.json {}
    end
  end
end
