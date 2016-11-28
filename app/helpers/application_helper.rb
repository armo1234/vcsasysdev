module ApplicationHelper

	def get_progression
		today = Date.today
		end_date = Date.new(2016, 6, 1)
		if today >= end_date
			number_of_days = (today - end_date)
		else
			number_of_days = (today + end_date)
		end
		return (number_of_days / 365.0) * 100
	end
end
