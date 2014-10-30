module PostsHelper

  def edit_tags(tagslist)
	currentTags = []
  	tagslist.each do |tag|
  	  currentTags += ["#{tag.name}"]
  	end
  	currentTags.uniq.join(', ')
  end

end
