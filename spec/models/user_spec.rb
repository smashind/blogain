require 'rails_helper'

describe 'User' do 

	before { @user = User.new(name: "Gary", username: "gtester", email: "validemail@msn.gov", password: "foobaarr", password_confirmation: "foobaarr", id: 1 ) }

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:username) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should be_valid }

	describe "is not valid without a name" do 
		before { @user.name = nil }
		it { should_not be_valid }
	end

	describe "is not valid without a username" do 
		before { @user.username = nil }
		it { should_not be_valid }
	end

	describe "is not valid without a password" do 
		before { @user.password = nil }
		it { should_not be_valid }
	end

	describe "is not valid without a matching password confirmation" do 
		before { @user.password_confirmation = "foob" }
		it { should_not be_valid }
	end

	describe "post association" do 
		before { @user.save }
		before { @post = Post.new(title: "This is a title", body: "This is the body", user_id: @user.id) }

		it "should destroy associated posts" do 
			posts = @user.posts.to_a
			@user.destroy
			expect(posts).to be_empty
		end
	end
end

