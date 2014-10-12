require 'rails_helper'

describe 'Post' do 

	let(:user) { User.new(name: "Gary", username: "gtester", email: "validemail@msn.gov", password: "foobaarr", password_confirmation: "foobaarr", id: 1 ) }
	before { @post = user.posts.build(title: "This is the title", body: "This is the body of the blog post", id: 1) }

	subject { @post }

	it { should respond_to(:title) }
	it { should respond_to(:body) }

	it { should be_valid }

	describe "when user id is not present" do 
		before { @post.user_id = nil }
		it { should_not be_valid }
	end

	describe "when title is not present" do 
		before { @post.title = nil }
		it { should_not be_valid }
	end

	describe "when body is not present" do 
		before { @post.body = nil }
		it { should_not be_valid }
	end

	describe "comment associations" do 

		before { @post.save }
		before { @comment = @post.comments.new(body: "Comment body", post_id: @post.id, user_id: user.id)}

		it "should destroy associated comments" do 
			comments = @post.comments.to_a
			@post.destroy
			expect(comments).not_to be_empty
			comments.each do |comment|
				expect(Comment.where(id: comment.id)).to be_empty
			end
		end
	end
end
