class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    #makes it so that you cant just go to /new when youre not logged in, and devise redirects you to sign up first.
    before_action :authenticate_user!, except: [:index, :show]
    
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
            redirect_to @post, notice: "Successfully created new Post"
        else
            #will render the new form
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @post.update(post_params)
            redirect_to @post, notice: "pin was successfully updated"
        else
            render 'edit'
        end
    
    end
    
    def destroy
        @post.destroy
        redirect_to root_path
    end
        
    private
    #Saves a version of the Post class that exists with the parameters equal to this post's ID. so for example, apollo.com/posts/2/ would mean :id == 2, so Post.find(params[:id]) would get you the 2nd instance of Post
    def find_post
        @post = Post.find(params[:id])
    end
    
    def post_params
        params.require(:post).permit(:title, :content, :image)
    end
end

