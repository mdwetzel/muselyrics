module UsersHelper
	def user_status(user)
		if user.admin? 
			"Admin"
		elsif user.moderator?
			"Moderator"
		else
			"User"
		end	
	end

	def user_participation(user)
		if user.comments.count > 1
			"#{user.comments.count} comments"
		else
			"No comments yet"
		end
	end
end
