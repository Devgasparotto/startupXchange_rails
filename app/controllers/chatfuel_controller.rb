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

		# response = {
		# 	"set_attributes": {
		# 		"isValidDate": "#{isValid}"
		# 	},
		# 	"block_names": ["TestBlock1"],
  # 			"type": "show_block",
  # 			"title": "Go!"
		# }
		# puts response
		# render json: response.to_json
	end

end
