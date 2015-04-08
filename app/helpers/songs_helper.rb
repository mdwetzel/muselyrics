module SongsHelper
	def madness_link
		madness = Song.madness

		if madness
			link_to madness.title.downcase, [madness.album, madness]
		else
			"madness"
		end
	end
end
