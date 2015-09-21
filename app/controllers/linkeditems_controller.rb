class LinkeditemsController < ApplicationController
    def show
        @item = Item.find(params[:id])
    end
end
