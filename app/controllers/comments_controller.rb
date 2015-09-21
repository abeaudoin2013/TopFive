class CommentsController < ApplicationController
	# before_action set_comment: :only [:create, :destroy]

	def create 
		@post = Post.find(params[:post_id])
		# @comment = @post.user_id.username
		Comment.create(comment_params)
		redirect_to @post, notice: "New comment created."
	end 

	def destroy
		@comment.destroy
		redirect_to root_path
	end 

	private 

	def comment_params
  	params.require(:comment).permit(:body).merge(user: current_user, post: @post)
  end 
end 