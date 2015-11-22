require 'rails_helper'

RSpec.describe PostsController, type: :controller do




let(:valid_session){
	{user_id: 1}
}

	describe "GET #index" do
		let(:post) { FactoryGirl.create(:post) }
		it "assigns the last ten posts @posts" do
			post
			get :index
			expect(assigns(:posts)).to eq [post]
		end
	end

	describe "GET #show" do
		let(:post) { FactoryGirl.create(:post) }
		it "assigns the requested post as @post" do
			get :show, {id: post.to_param}
			expect(assigns(:post)).to eq post
		end

		# let(:comment) { FactoryGirl.create(:comment)}
		it "makes a new comment and assigns it to @comment" do
			post
			comment = build(:comment)
			get :show, {id: post.to_param}
			expect(assigns(:comment)).to be_a_new(Comment)
		end

		it "assigns all comments associated with post to @comments" do
			post
			comment = create(:comment)
			get :show, {id: post.to_param}
			expect(assigns(:comments)).to eq [comment]
		end 
	end

	describe "GET #new" do

		let (:post) { FactoryGirl.create(:post) }
		let (:user) { FactoryGirl.create(:user) }
		it 'assigns a new post to @post' do
			user
			get :new, {}, valid_session
			expect(assigns(:post)).to be_a_new(Post)
		end

	end

	describe "GET #edit" do
		let (:post) { FactoryGirl.create(:post) }
		let (:user) { FactoryGirl.create(:user) }
		it 'assigns the requested post to @post' do
			user
			get :edit, {id: post.to_param}, valid_session
			expect(assigns(:post)).to eq post
		end
	end
	
	describe "POST #create" do

			let (:user) { FactoryGirl.create(:user) }
			it "creates a new Post html style" do
				user
				build(:post)
				expect {
					post :create, {post: attributes_for(:post)}, valid_session
				}.to change(Post, :count).by(1)
			end

			it "creates a new post ajax style" do
				user
				build(:post)
				expect {
					xhr :post, :create, {post: attributes_for(:post)}, valid_session
				}.to change(Post, :count).by(1)
			end

	end 

	describe "DELETE #destroy" do
		context "html style" do
		let!(:post) { FactoryGirl.create(:post) }
		let (:user) { FactoryGirl.create(:user) }
			it "destroys the post, html style" do
				user
				expect {
					delete :destroy, {id: post.to_param}, valid_session
				}.to change(Post, :count).by(-1)
			end

			it "redirects to the html page" do
				user
				delete :destroy, {id: post.to_param}, valid_session 
				expect(response).to redirect_to(posts_url)
			end
		end 
		context "ajax style" do
		let (:user) { FactoryGirl.create(:user) }
			it "destroys the post, ajax style" do
				user
				expect {
					xhr :delete, :destroy, {id: post.to_param}, valid_session
				}.to change(Post, :count).by(-1)
			end
		end

	end



end
















