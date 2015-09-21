class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  	session[:user_id] = @user.id
  	redirect_to @user, notice: "Welcome to Top Five"
  end 

  def show
  end

  def edit
  end

  def update
  	@user.update(user_params)
  	redirect_to @user, notice: "Updated!"
  end 

  def destroy
  end 

  def profile
    @user = current_user
    render :show
  end 

  private

  def user_params
  	params.require(:user).permit(:username, :email, :password, :avatar, :occupation, :hometown, :instrument, :age)
  end 

  def set_user
  	begin 
  		@user = User.find(params[:id])
  	rescue
  		flash[:notice] = "Cannot find that user. Sorry."
  		redirect_to users_path
  	end 
  end 

end
