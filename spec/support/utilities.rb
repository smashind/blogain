include ApplicationHelper

def tag_list
	tags.join(", ")
end

def tag_list=(tags_string)
	tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
	new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
	self.tags = new_or_found_tags
end

def sign_in(user, options={})
	visit new_user_session_path
	fill_in "Email", with: user.email 
	fill_in "Password", with: user.password 
	click_button "Log in"
end