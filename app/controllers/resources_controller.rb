class ResourcesController < ApplicationController
   def index
    #for simple filters
    @projects = Item.where(type: 'Project')
    query = Tag.all(:tags).items.query_as(:tagitems)
    @tags = query.with(:tags, 'count(tagitems) AS count').order('count DESC').limit(6).pluck(:tags)

    #for advanced filters
    @taggings = ''
    @filter = 'All Items'
    @related_project = ''
    @selectTags = []
    @search

    Item.all.each do |it|
        it.tags.each do |t|
            if !(t.items.map {|i| i.id}).include? it.id
                t.items << it
            end
        end
    end
    
    @item = Item.first
    @items = Item.all

    # Filters
    if params[:project].present?
        @project = Item.find(params[:project])
        @items = @items.where('n.uuid IN {items}', items: @project.items.map { |i| i.id })
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
         @items = @items.where(title: /.*#{Regexp.escape(params[:search])}.*/i)
         @search = 'Search Result for "' + params[:search] + '"'
    end

    # Pagination
    @items = @items.page(params[:page]).per(25)

    respond_to do |format|
        format.html {}
        format.js {}
        format.json {}
    end
  end
  def search
    @items = Item.all
    if params['itemTyle'].present?
        @items = @items.where(type:params[:type])
    end
    if params['keyword'].present?
        @items = @items.where(title: /.*#{Regexp.escape(params[:keyword])}.*/i)
    end
    if params['filter_tags'].present?
        params['filter_tags'].each do |tag| 
            @tag = Tag.find(tag)
            @items = @items.where('n.uuid IN {items}', items: @tag.items.map {|i| i.id })
        end
    end
    if params['filter_items']
        params['filter_items'].each do |item| 
            @project = Item.find(item)
            @items = @items.where('n.uuid IN {items}', items: @project.items.map {|i| i.id})
        end
    end
     
    @items = @items.page(params[:page]).per(25)


    respond_to do |format|
        format.html {}
        format.js {}
        format.json {}
    end
  end
end
