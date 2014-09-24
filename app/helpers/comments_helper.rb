module CommentsHelper
	def commentuser(id)
		User.find(id)
	end

	def commentpost(id)
		Post.find(id)
	end
end
