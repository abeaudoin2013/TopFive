class SessionsController < ApplicationController
	def new
	end 

	def create 
		@user = User.find_by(email: params[:email])
		if @user and @user.password == params[:password]
			session[:user_id] = @user.id #session[:user_id] is a hash that is stored in the user's computer kind of like a cookie
			redirect_to @user, notice: 'logged in!'
		else 
			redirect_to login_path, notice: 'Login information is wrong.'
		end 
	end 

	def destroy
		session[:user_id] = nil
		redirect_to login_path, notice: 'logged out!'
 	end 

end 