class CommentsController < ApplicationController
    def create
        @item = Item.find(params[:item_id])
        @comment = Comment.new(comment_params)
        if @comment.save
            @item.comments << @comment
            @comment.items = @item
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
