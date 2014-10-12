class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :user_id, presence: true
	validates :title, presence: true
	validates :body, presence: true
end
