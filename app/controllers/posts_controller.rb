class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :destroy]
	before_action :set_post, only: [:edit, :show, :destroy]

  def index
  	@posts = Post.last(10).reverse
  end

  def new
  	@post = Post.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
  	@post = Post.create(post_params)
    if @post.save
      respond_to do |format|   
      	format.html {redirect_to posts_path, notice: "Squibbily Dibbily Doo!"}
        format.js 
      end
    else
      render :new, notice: "You need a title for your post"
    end
  end 

  def edit
  end

  def show
    @comment = Comment.new
    @comments = Comment.all
  end

  def destroy
  	@post.destroy
    respond_to do |format|
      format.html {redirect_to posts_path, notice: "Deleted!"}
      format.js {render nothing: true}
    end
  end 

  private

  def post_params
  	params.require(:post).permit(:title, :five, :four, :three, :two, :one, :pics).merge(user: current_user)
  end 
  
  def set_post
  	begin 
  		@post = Post.find(params[:id])
  	rescue
  		flash[:notice] = "We can't find that post"
  		redirect_to posts_path
  	end
  end 
end
