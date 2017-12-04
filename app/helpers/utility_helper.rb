module UtilityHelper

	def IsValidFutureDate(dateText)
		require 'date'
		begin
			#Expects format dd/MM/YYYY
			inputDate = Date.parse(dateText)
			return inputDate > Time.now
		rescue ArgumentError
			return false
		end
	end

end
