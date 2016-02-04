class SettingsController < ApplicationController
	before_action :authenticate_user!
	before_filter :set_variables

	def set_variables
        @per_page = 50
    end

	def index
		@alltags = Tag.all.order('lower(n.name)')
		@tags = @alltags.order('lower(n.name)')
		# Pagination
    	@tags = @tags.page(params[:page]).per(@per_page)
	end

    def suggestMerges
        @tags = Tag.all.order('lower(n.name)');
        @similarTags = []
        @tags.each_with_index do |tag, index|
            if index < @tags.length - 1
                temp = ''
                if tag.name.downcase == @tags[index + 1].name.downcase || @tags[index+1].name.downcase == tag.name.downcase + 's'
                    if temp == ''
                        temp = tag.name.downcase
                    else 
                        if temp != tag.name.downcase && temp != tag.name.downcase + 's'
                            break
                        end
                    end
                    @similarTags.push(tag.id)
                    @similarTags.push(@tags[index+1].id)
                end
            end
        end
        @similarTags.uniq
        @tagString = @similarTags.join(" ")

        respond_to do |format|
            format.html {}
            format.js {}
        end 
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
            if params[:deleteAfterMerge] && @sourceTag.id != @destTag.id
                @sourceTag.destroy
            end
        end
        @destTag.save
        redirect_to settings_path
    end

    def orderTags
        @tags = Tag.all
        @tags.each do |tag|
            tag.trending_count = 0
            tag.save
        end
        @trending = ''
        if params[:order].present?
            case params[:order]
            when 'name'
                @tags = @tags.order('lower(n.name)')
            when 'trending'
                @trending = 'trending'
                trendingTime = 1.week
                if params[:trending].present?
                    case params[:trending]
                        when 'week'
                            trendingTime = 1.week
                        when 'month'
                            trendingTime = 1.month
                        when 'year'
                            trendingTime = 1.year
                        when 'time'
                            trendingTime = false
                    end
                end
                if trendingTime
                    query = Tag.all(:tags).items.where('tagitems.created_at > ?', (Time.now - trendingTime).to_i).query_as(:tagitems)
                else
                    query = Tag.all(:tags).items.query_as(:tagitems)
                end
                @tags = query.with(:tags, 'count(tagitems) AS count').order('count DESC').pluck(:tags, 'count')
                @tags.each do |tag_count|
                    tag_count[0].trending_count = tag_count[1]
                    tag_count[0].save
                end
                @tags = Tag.all.order('-n.trending_count, lower(n.name)')
            end
        else 
            @tags = @tags.order('lower(n.name)')
        end
       
        @tags = @tags.page(params[:page]).per(@per_page)

        render partial:  "listtagsdisplay";
      end
end
