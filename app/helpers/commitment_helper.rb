module CommitmentHelper
	include ChatfuelHelper


	def SendCommitmentOfferToEntrepreneur(helperName, comID, comOffer, entID)
		userAttributes = {
			helperName: "#{helperName}",
			commitmentID: "#{comID}",
			commitmentOffer: "#{comOffer}"
		}
		blockName = "ReceiveCommitmentOffer"
		SendMessageToIndividual(entID, blockName, userAttributes)
	end	

end
