module CommitmentHelper
	include ChatfuelHelper


	def SendCommitmentOfferToEntrepreneur(helperName, comID, comOffer, entID)
		userAttributes = {
			helperName: "#{helperName}",
			commitmentID: "#{comID}",
			commitmentOffer: "#{comOffer}"
		}
		blockName = "ReceiveCommitmentOffer"
		ent = Individual.find_by(id: entID)
		if !ent.nil?
			SendMessageToIndividual(ent.sourceID, blockName, userAttributes)
		end
		
	end	

end
