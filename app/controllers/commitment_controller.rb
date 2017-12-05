class CommitmentController < ApplicationController
	include UtilityHelper

	def CreateCommitment
		sourceID = params['messenger user id']
		comID = 0
		ind = Individual.find_by(sourceID: sourceID)
		if !ind.nil?
			inputDate = params[:inputDate]
			entrepreneurID = params[:entrepreneurID]
			commitmentOffer = params[:commitmentOffer]
			if !inputDate.nil? && !inputDate.empty? && IsValidFutureDate(inputDate)
				if !entrepreneurID.nil? && !entrepreneurID.empty?
					if !commitmentOffer.nil? && !commitmentOffer.empty?
						com = Commitment.new(helper_id: ind.id, entreprenuer_id: entrepreneurID, commitmentOffer: commitmentOffer, commitmentDueDate: inputDate, commitmentStatus: 1)
						com.save
						comID = com.id
					end
				end
			end
		end

		response = {
			"set_attributes": {
				"commitmentID": "#{comID}"
			}
		}

		render json: response		
	end
end
