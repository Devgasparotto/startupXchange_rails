class ChatfuelController < ApplicationController
	skip_before_action :verify_authenticity_token

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
