FactoryGirl.define do 
	factory :user do 
		name     "John Camberdella"
		username "johnniec"
		email    "johnc2@juno.gov"
		password "foobbarr"
		password_confirmation "foobbarr"
	end

	factory :post do 
		title "Post title"
		body "This is the post body"
		published true
		user
	end
end
