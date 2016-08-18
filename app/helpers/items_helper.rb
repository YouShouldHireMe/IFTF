module ItemsHelper
	def time_from_today(the_time)
		seconds 	= (Time.now - the_time).to_i
		minutes		= seconds / 60
		hours		= minutes / 60
		days		= hours / 24
		months		= days / 30
		years		= months / 12

		if seconds < 60
			result	= seconds.to_s + ' seconds ago'
		elsif minutes < 60
			result	= minutes.to_s + ' minutes ago'
		elsif hours < 24
			result	= hours.to_s + ' hours ago'
		elsif days < 30 
			result	= days.to_s + ' days ago'
		elsif months < 24
			result = months.to_s + ' months ago'
		else
			result = years.to_s + ' years ago'
		end
		
		return result
	end
end
