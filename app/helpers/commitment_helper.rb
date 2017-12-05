module CommitmentHelper
	include ChatfuelHelper


	def SendCommitmentOfferToEntrepreneur(helperName, comID, comOffer, entID)
		userAttributes = {
			helperName: "#{helperName}",
			commitmentID: "#{comID}",
			commitmentOffer: "#{comOffer}"
		}
		blockName = "ReceiveHelperOffer"
		SendMessageToIndividualByID(entID, blockName, userAttributes)
	end

	def SendCommitmentAcceptanceToHelper(entName, comID, helperID)
		userAttributes = {
			entrepreneurName: "#{entName}",
			commitmentID: "#{comID}"
		}
		blockName = "CommitmentOfferAccepted"
		SendMessageToIndividualByID(helperID, blockName, userAttributes)
	end

	def SendCommitmentRejectionToHelper(entName, comID, helperID)
		userAttributes = {
			entrepreneurName: "#{entName}",
			commitmentID: "#{comID}"
		}
		blockName = "CommitmentOfferRejected"
		SendMessageToIndividualByID(helperID, blockName, userAttributes)
	end

	def SendCommitmentCompletionPrompt(helperName, comID, entID)
		userAttributes = {
			helperName: "#{helperName}",
			commitmentID: "#{comID}"
		}
		blockName = "CommitmentCompletePrompt"
		SendMessageToIndividualByID(entID, blockName, userAttributes)
	end

end
