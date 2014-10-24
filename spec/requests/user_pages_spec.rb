require 'rails_helper'

describe "User pages" do 

	subject { page } 

	describe "logging in" do 
		let(:user) { FactoryGirl.create(:user) }
		before(:each) do 
			sign_in user
		end

		it "should redirect to user profile page" do 
			expect(current_path).to eq user_path(user)
		end

		describe "profile page" do
			before { FactoryGirl.create(:post, user: user) }
			before { @comment = Comment.create(user_id: 1, post_id: 1, body: "Comment body") }
			before { visit user_path(user) }
			#after { save_and_open_page	}

			it { should have_content("#{user.username}'s posts") }
			it { should have_content("Post title") }
			it { should have_link("Read more", href: "/posts/1") }

			it { should have_content("#{user.username}'s comments") }
			it { should have_content("Comment body") }
			it { should have_link("Post title", href: "/posts/1") }
		end
	end

	describe "signup page" do 
		before { visit new_user_registration_path }

		it { should have_content('Create a New Account') }
		it { should have_selector(:button, 'Create account') }
	end

	describe "login page" do 
		before { visit new_user_session_path }

		it { should have_content('Log into your account') }
		it { should have_link('Get one here', href: new_user_registration_path) }
		it { should have_selector(:button, 'Log in') }
	end

end
