require 'rails_helper'

describe 'Post pages' do 

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before(:each) do 
		sign_in user
	end 

	describe "posts creation" do 
		before { visit new_post_path } 

		describe "with invalid information" do 

			it "should not create a post" do 
				expect { click_button "Create Post" }.not_to change(Post, :count)
			end

			describe "error messages" do 
				before { click_button "Create Post"}
				it { should have_content("errors") }
			end

		end

		describe "with valid information" do 

			before { fill_in 'post_title', with: "title here"}
			before { fill_in 'post_body', with: "body here"}
			before { page.check('post_published') }

			it "should create a post" do 
				expect { click_button "Create Post" }.to change(Post, :count).by(1)
			end

			it "should be published" do 
				click_button "Create Post"
				visit root_path
				expect(page).to have_content("title here")
			end	

		end

		describe "with valid information and unpublished" do 

			before { fill_in 'post_title', with: "unpublished post"}
			before { fill_in 'post_body', with: "unpublished post body"}
			before { click_button "Create Post" }			

			it "should not be published" do 
				visit root_path
				expect(page).not_to have_content("unpublished post")
			end

			it "should be a draft" do 
				visit drafts_path
				expect(page).to have_content("unpublished post")
			end
		end
	end
end
