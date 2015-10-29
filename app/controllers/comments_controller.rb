class CommentsController < ApplicationController
    def create
        if current_user 
            @item = Item.find(params[:item_id])
            @comment = Comment.new(comment_params)
            if @comment.save
                @item.comments << @comment
                @comment.items = @item
                current_user.comments << @comment
                @comment.users = current_user
                redirect_to root_path
            else
                render 'new'
            end
        end
    end

    def destroy
        @item = Item.find(params[:item_id])
        @comment = @item.comments.find(params[:id])
        @comment.destroy

        redirect_to root_path
    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
