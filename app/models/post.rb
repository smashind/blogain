class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :user_id, presence: true
	validates :title, presence: true
	validates :body, presence: true
	has_many :taggings
	has_many :tags, through: :taggings
	scope :published, -> { order('id DESC').where(published: true) }
  	scope :draft, -> { where(published: false) }
  	has_many :pictures, as: :image
  	accepts_nested_attributes_for :pictures


	def tag_list
		tags.join(", ")
	end

	def tag_list=(tags_string)
		tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
		new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
		self.tags = new_or_found_tags
	end
end
