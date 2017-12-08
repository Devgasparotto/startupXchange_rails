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
		if totalNumComs > 0 && completedNumComs > 0
			reliabilityRating = (completedNumComs*10000)/totalNumComs
		end
		
		response = {
			"set_attributes": {
				"reliabilityRating": "#{reliabilityRating}",
				"completedNumCommitments": "#{completedNumComs}"
			}
		}

		render json: response
	end
end
