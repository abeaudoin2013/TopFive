class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :destroy]
	before_action :set_post, only: [:edit, :show, :destroy]

  def index
  	@posts = Post.last(10).reverse
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.create(post_params)
  	redirect_to posts_path, notice: "Squibbily Dibbily Doo!"
  end 

  def edit
  end

  def show
    @comment = Comment.new
    @comments = Comment.all
  end

  def destroy
  	@post.destroy
  	redirect_to posts_path, notice: "Deleted!"
  end 

  private

  def post_params
  	params.require(:post).permit(:title, :five, :four, :three, :two, :one).merge(user: current_user)
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
