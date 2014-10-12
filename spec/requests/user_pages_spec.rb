require 'rails_helper'

describe "User pages" do 

	subject { page } 

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
