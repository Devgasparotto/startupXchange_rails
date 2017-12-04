class ChatfuelController < ApplicationController
	include UtilityHelper

	def IsValidCommitmentDate
		inputDate = params[:inputDate]
		if !inputDate.nil? && !inputDate.empty?
			isValid = IsValidFutureDate(inputDate)
		end
		
		response = {
			"set_attributes": {
				"isValidDate": "#{isValid}"
			}
		}

		render json: response
	end

end
