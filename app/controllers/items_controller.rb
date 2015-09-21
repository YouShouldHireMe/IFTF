class ItemsController < ApplicationController
    def new
        if params[:quick_url].present?
            
        end
        @item = Item.new
        
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
        @items = @item.items
        
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

        redirect_to root_path
    end
end
