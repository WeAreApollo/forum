class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    def index
        @posts = Post.all.order("created_at DESC")
    end
    
    def show
    end
    
    def new
        @post=current_user.posts.build  #builds a new post under the current user profile
    end
    
    def create
        #builds a new post under the current user profile given the post params the user has entered (i think, lol)
        @post=current_user.posts.build(post_params)
        #if the post can be saved
        if @post.save
            #the post will be redirected to the post show page
            redirect_to @post
        else
            #will render the new form
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    
    end
    
    def destroy
        @post.destroy
        redirect_to root_path
    end
        
    private
    #find post grabs the post being dealt with based on the post 
    def find_post
        @post = Post.find(params[:id])
    end
    
    def post_params
        params.require(:post).permit(:title, :content)
    end
end

