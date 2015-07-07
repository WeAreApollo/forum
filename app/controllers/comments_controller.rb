class CommentsController < ApplicationController

    def create
        @post=Post.find(params[:post_id])
        #creates a comment under the db comments table that belong_to the @post
        @comment = @post.comments.create(params[:comment].permit(:comment))
        @comment.user = current_user if current_user
        @comment.save
        #if you can save the comment, take us to the 
        if @comment.save
            redirect_to post_path(@post)
        else
            render 'new'
        end
    end
    
    def edit
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if @comment.update(params[:comment].permit(:comment))
            redirect_to post_path(@post)
        else
            render 'edit'
        end
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

end
