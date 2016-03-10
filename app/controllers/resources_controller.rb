class ResourcesController < ApplicationController
   before_filter :set_variables
   def set_variables
        @per_page = 15
    end

   def index
    @filter = false
    #for simple filters
#   @projects = Item.where(type: 'Project')
    query = Tag.all(:tags).items.query_as(:tagitems)
    @tags = query.with(:tags, 'count(tagitems) AS count').order('count DESC').pluck(:tags)

    #for advanced filters
    @taggings = ''
    @filter = 'All Items'
    @related_project = ''
    @selectTags = []
    @search


#    Item.all.each do |it|
#        it.tags.each do |t|
#            if !(t.items.map {|i| i.id}).include? it.id
#                t.items << it
#            end
#        end
#        if !(it.creation_date)
#            it.creation_date = Date.parse('1 Jan 2015')
#            it.save
#        end
#        if !(it.created_at)
#            it.created_at = DateTime.parse(it.creation_date.to_s)
#            it.save
#        end
#    end

    #@item = Item.first
    #@items = Item.all
    item_order = 'n.creation_date DESC, n.created_at DESC'

    if params[:order].present?
        case params[:order]
        when 'date_asc'
            #@items = @items.order('n.creation_date ASC, n.created_at ASC, -n.upvotes')
            item_order = 'n.creation_date ASC, n.created_at ASC, -n.upvotes'
        when 'date_desc'
            #@items = @items.order('n.creation_date DESC, n.created_at DESC, -n.upvotes')
            item_order = 'n.creation_date DESC, n.created_at DESC, -n.upvotes'
        when 'fav'
            #@items = @items.order('-n.upvotes, -n.creation_date, -n.created_at')
            item_order = '-n.upvotes, -n.creation_date, -n.created_at'
        end
    #else 
        #@items = @items.order('n.creation_date DESC, n.created_at DESC')
    end
    @items = Item.all.order(item_order)

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
     @items = @items.page(params[:page]).per(@per_page)

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
            @items = @items.where('n.uuid IN {relateditems}', relateditems: @project.items.map {|i| i.id})
        end
    end

    @items = @items.page(params[:page]).per(@per_page)


    respond_to do |format|
        format.html {}
        format.js {}
        format.json {}
    end
  end
  def filter
    @filter = true
    @items = Item.all
    @type = 'All items'
    @tagging = ''
    @related_project = ''
    if params[:order].present?
        case params[:order]
        when 'date_asc'
            @items = @items.order('n.creation_date ASC, n.created_at ASC, -n.upvotes')
        when 'date_desc'
            @items = @items.order('n.creation_date DESC, n.created_at DESC, -n.upvotes')
        when 'fav'
            @items = @items.order('-n.upvotes, -n.creation_date, -n.created_at')
        end
    else 
        @items = @items.order('n.creation_date DESC, n.created_at DESC')
    end
    if params[:type].present? && params[:type] != 'no_selection'
        @type  = params[:type] + 's'
        @items = @items.where(type:params[:type])
    end
    if params[:tag].present? && params[:tag] != 'no_selection'
        @tag = Tag.find(params[:tag])
        @tagging = ' tagged with "' + @tag.name + '"';
        @items = @items.where('n.uuid IN {items}', items: @tag.items.map {|i| i.id })
    end
    if params[:item].present? 
        @related = Item.find(params[:item])
        @related_project = ' related to "' + @related.title + '"'
        @items = @items.where('n.uuid IN {relateditems}', relateditems: @related.items.map {|i| i.id}) 
    end 
    @items = @items.page(params[:page]).per(@per_page)

    render partial:  "listdisplay";

    respond_to do |format|
        format.html {}
        format.js {}
        format.json {}
    end
  end
end
