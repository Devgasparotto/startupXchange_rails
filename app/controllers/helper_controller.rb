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
		helper = Individual.find_by(sourceID: params['messenger user id'])
		coms = Commitment.where(helper_id: helper.id)
		completeCS = CommitmentStatus.find_by(statusName: 'completionAccepted')
		completeComs = coms.where(commitmentStatus_id: completeCS.id)
		reliabilityRating = 0
		totalNumComs = coms.count
		completedNumComs = completeComs.count
		puts totalNumComs
		puts completedNumComs
		#if totalNumComs > 0 && completedNumComs > 0
			reliabilityRating = (completeComs.count/coms.count)*10000
		#end
		
		response = {
			"set_attributes": {
				"reliabilityRating": "#{reliabilityRating}"
			}
		}

		render json: response
	end
end
