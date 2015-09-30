class ItemsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [:show, :showlinks]
    def new
        @item = Item.new
        
        if params[:quick_url].present?
            require 'open-uri'
            require 'json'
            key = '7ae8a289ea5342feb466983a44a8ad26'
            url = 'http://api.embed.ly/1/extract?key=' + key + '&url=' + params[:quick_url]
            result = JSON.parse(open(url).read);
            @item.title = result['title']
            @item.description = result['description']
            @item.url = params[:quick_url]
            @item.image = result['images'][0]['url']    
        end
        respond_to do |format|
            format.html {}
            format.js {}
            format.json {}
        end
    end

    def edit
        @item = Item.find(params[:id])

        respond_to do |format|
            format.html{}
            format.js{}
        end
    end

    def link
        @item = Item.find(params[:id])
    end
    
    def create
        @item = Item.new(params[:item])

        if @item.save
            @item.update(params[:item])
            redirect_to root_path
        else
            render 'new'
        end
    end
    
    def update
        @item = Item.find(params[:id])
        if @item.update(params[:item])
            redirect_to root_path
        else
            render 'edit'
        end
    end

    def show
        @item = Item.find(params[:id])
        
        query = Tag.all(:tags).items.query_as(:tagitems)
        @top_tags = query.with(:tags, 'count(tagitems) AS count').where('NOT tags.name IN ?', @item.tags.map { |t| t.name }).order('count DESC').limit(4).pluck(:tags)
 
        respond_to do |format|
            format.html {}
            format.js {}
            format.json {}
        end
    end
    
    def destroy
        @item = Item.find(params[:id])
        @item.destroy

        redirect_to root_path
    end

    def showlinks
        @item = Item.find(params[:id])
        @items = @item.items.page(params[:page]).per(15)
        
        respond_to do |format|
            format.html {}
            format.js {}
        end
    end
   
    def edittags
        @item = Item.find(params[:id])
        @tags = Tag.all

        respond_to do |format|
            format.html {}
            format.js {}
        end
    end
 
    def addtag
        @tag = Tag.find_by name: params[:tagname]
        if @tag
            @item = Item.find(params[:id])
            @item.tags << @tag
            @tag.items << @item
        else
            @tag = Tag.new(name: params[:tagname])
            @item = Item.find(params[:id])
            @item.tags << @tag
            @tag.items << @item
        end
        
        respond_to do |format|
            format.json {}
            format.html {}
        end
        render json: @tag
    end

    def removetag
        @tag = Tag.find_by name: params[:tagname]
        @item = Item.find(params[:id])
        @item.tags.delete(@tag)
        @tag.items.delete(@item)
        
        respond_to do |format|
            format.html {}
            format.js {}
        end 
    end
end
