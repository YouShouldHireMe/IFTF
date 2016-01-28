class TagsController < ApplicationController
	def new
    end

    def edit
        @tag = Tag.find(params[:id])

        respond_to do |format|
            format.html{}
            format.js{}
        end
    end
    
    def update
        @tag        = Tag.find(params[:id])
        newName     = params[:tag][:name]
        @dup_tag    = Tag.where(name: newName)
        @has_dup    = false
        if newName != @tag.name && @dup_tag.length > 0
            @has_dup = true
            @dup_tag = @dup_tag.first
        else
            @tag.update(params[:tag])
        end
        respond_to do |format|
            format.html {}
            format.js {}
            format.json {}
        end
    end

    def destroy
        @tag = Tag.find(params[:id])
        @tag.destroy

        redirect_to settings_path
    end

end
