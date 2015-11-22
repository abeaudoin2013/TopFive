require 'rails_helper'

RSpec.describe UsersController, type: :controller do


	let(:valid_session){
		{user_id: 1}
	}


	# Most of these get requests are just verifying that 
	#there is a user going into those get requests

	describe "GET #index" do 
		let (:user) { FactoryGirl.create(:user) }
		
		it 'assigns all users as @users' do 
			get :index
			expect(assigns(:users)).to eq([user]) #this user is eqaul to the Factory Girl user
		end
	end

	describe "GET #show" do
		let (:user) { FactoryGirl.create(:user) }
		it 'assigns the requested user as @user' do
			get :show, {id: user.to_param}
			expect(assigns(:user)).to eq user #:user in this line refers to the instance variable in the controller method
		end
	end

	describe "GET #new" do 
		let (:user) { FactoryGirl.create(:user) }
		it 'assigns a new user as @user' do
			get :new, {}, valid_session #this is giving it a fake sessions_id
			expect(assigns(:user)).to be_a_new(User) #Factory girl is making a class object of User. 
		end
	end

	describe "GET #edit" do
		let (:user) { FactoryGirl.create(:user) }
		it 'assigns the requested user as @user' do
			get :edit, {id: user.to_param}, valid_session
			expect(assigns(:user)).to eq user
		end
	end


	#Now we need to descrive post methods 

	describe "POST #create" do
#beacuase we're dealing with sending information
#we need to make sure to test for valid information
#being sent, as well as invalid information being sent

		context "with vaild params" do
			it "creates a new User" do 
				build(:user) #factory girl makes a User.new thing
				attributes = attributes_for(:user) #store attributes of our Factory Girl user in an attributes var
				expect {
					post :create, {user: attributes}, valid_session #set our User.new eq to our User attributes from factory girl
				}.to change(User, :count).by(1)
			end

			it "assigns the newly created user as @user" do
				build(:user)
				attributes = attributes_for(:user)
				post :create, {user: attributes}, valid_session
				expect(assigns(:user)).to be_a(User)
				expect(assigns(:user)).to be_persisted
			end 

			it "redirects to the created user" do
				build(:user)
				attributes = attributes_for(:user)
				post :create, {user: attributes}, valid_session
				expect(response).to redirect_to(User.last)
			end
		end

		context "with invalid params" do

			it 'assigns the user as @user' do
				build(:user)
				post :create, {user: attributes_for(:user, username: nil) }, valid_session #you can actually just define attributes_for on this line instead of storing in a var
				expect(assigns(:user)).to be_a_new(User)
			end

			it 're-renders the "new" template' do
				build(:user)
				post :create, {user: attributes_for(:user, username: nil) }, valid_session
				expect(response).to render_template("new")
			end

		end

	end

	describe "PUT #update" do
		let (:user) { FactoryGirl.create(:user) }
		context "with valid params" do

			it 'updates the requested user' do 
				put :update, {id: user.to_param, user: attributes_for(:user, username: "Soupie")}, valid_session
				user.reload
				expect(user.username).to eq "Soupie"
			end

			it "assigns the requested user as @user" do
				put :update, {id: user.to_param, user: attributes_for(:user, username: "Soupie")}, valid_session
				user.reload
				expect(assigns(:user)).to be_a(User)
				expect(assigns(:user)).to be_persisted
			end

			it "redirects to the updated user" do
				put :update, {id: user.to_param, user: attributes_for(:user, username: "Soupie")}, valid_session
				expect(response).to redirect_to(user) 
			end


		end

		context "with invalid params" do
		let (:user) { FactoryGirl.create(:user) }
			it "assigns the user as @user" do
				put :update, {id: user.to_param, user: attributes_for(:user, username: nil)}, valid_session
				expect(assigns(:user)).to be_a(User)
			end

			it "re-renders the 'edit' template" do
				put :update, {id: user.to_param, user: attributes_for(:user, username: nil)}, valid_session
				expect(response).to render_template("edit")
			end

		end

	end


	describe "DELETE #destroy" do 
	let! (:user) { FactoryGirl.create(:user) } #the bang is so that it is saved to the database so that the test can delete it by 1
		it "destroys the requested user" do
			expect {
				delete :destroy, {id: user.to_param}, valid_session
			}.to change(User, :count).by(-1)

		end	

		it 'redirects to the user list' do
			delete :destroy, {id: user.to_param}, valid_session
			expect(response).to redirect_to(users_url)
		end
	end

end












