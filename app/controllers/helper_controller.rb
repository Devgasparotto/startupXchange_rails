class HelperController < ApplicationController
	skip_before_action :verify_authenticity_token

	def SetIndividualAsHelper
		ind = Individual.find_by(sourceID: params['messenger user id'])
		puts ind
		if !ind.nil?
			ind.isHelper = 1
			ind.isEntreprenuer = 0
			ind.save
		end

		render html: "Pass"
	end

	def GetReliabilityRating
		coms = Commitment.where(helper_id: params['messenger user id'])
		
		
		response = {
			"set_attributes": {
				"reliabilityRating": "#{reliabilityRating}"
			}
		}

		render json: response
	end
end
