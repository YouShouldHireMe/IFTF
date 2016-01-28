class SettingsController < ApplicationController
	before_action :authenticate_user!
	before_filter :set_variables

	def set_variables
        @per_page = 50
    end

	def index
		@alltags = Tag.all
		@alltags = @alltags.order('lower(n.name)')
		# Pagination
    	@tags = @alltags.page(params[:page]).per(@per_page)
	end


    def mergeTags
        @destTag  = Tag.find(params[:destinationTag])
        params[:sourceTags].each do |tagId|
            @sourceTag = Tag.find(tagId)
            @sourceTag.items.each do |item|
                unless @destTag.items.include?(item)
                    @destTag.items << item
                    item.tags << @destTag
                    item.save
                end
            end
            if params[:deleteAfterMerge]
                @sourceTag.destroy
            end
        end
        @destTag.save
        redirect_to settings_path
    end
end
