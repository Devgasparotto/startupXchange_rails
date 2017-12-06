class CommitmentController < ApplicationController
	skip_before_action :verify_authenticity_token

	include UtilityHelper
	include CommitmentHelper

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
						puts "Beginning Commitment Creation"
						cs = CommitmentStatus.find_by(statusName: 'offerSent')
						com = Commitment.new(helper_id: ind.id, entreprenuer_id: entrepreneurID, commitmentOffer: commitmentOffer, commitmentDueDate: inputDate, commitmentStatus_id: cs.id)
						com.save #TODO: this should be after the SendCommitOfferToEntrepreneur
						comID = com.id
						helperName = "#{ind.firstName} #{ind.lastName}"
						puts entrepreneurID
						SendCommitmentOfferToEntrepreneur(helperName, comID, commitmentOffer, entrepreneurID)
						puts "Offer sent"
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

	def ViewCommitments
		response = {
	      messages: [
	        {
	          attachment: {
	            type: "template",
	            payload: {
	              template_type: "generic",
	              elements: []
	            }
	          }
	        }
	      ]
	    }

	    begin
    		sourceID = params['messenger user id']
			ind = Individual.find_by(sourceID: sourceID)
			offerAcceptedCS = CommitmentStatus.find_by(statusName: 'offerAccepted')
			completionRequestCS = CommitmentStatus.find_by(statusName: 'completionRequest')
			completionRejectedCS = CommitmentStatus.find_by(statusName: 'completionRejected')
			commitments = Commitment.where("helper_id = #{ind.id} AND (commitmentStatus_id = #{offerAcceptedCS.id} OR commitmentStatus_id = #{completionRequestCS.id} OR commitmentStatus_id = #{completionRejectedCS.id})")
			#commitments = Commitment.where((helper_id: ind.id, commitmentStatus_id: offerAcceptedCS.id).or(helper_id: ind.id, commitmentStatus_id: completionRequestCS.id).or(helper_id: ind.id, commitmentStatus_id: completionRejectedCS.id)).to_a
			
			numCards = commitments.length / 3
			numCards += 1 if (commitments.length % 3 ) > 0
			cards = []
			elements = response[ :messages ][0][ :attachment ][ :payload ][ :elements ]
			(0..numCards-1).each do |i|
				cStart = i*3
				cEnd = [cStart + 2, commitments.length-1 ].min
				element = {
				title: "Select a commitment to complete",
				subtitle: nil,
				image_url: nil,
				buttons: 
				(cStart..cEnd).map do |j|
					{
						type: "show_block",
						title: "#{commitments[j].id} #{commitments[j].commitmentOffer}",
						block_name: "AttemptToComplete",
						set_attributes: {
							commitmentIDToComplete: "#{commitments[j].id}"
						}
					}
				end
			}
			elements << element
			end
			rescue Exception => e
				response = {}
				puts e.backtrace.join( "\n")
			end

			render json: response
	end

	def AcceptCommitmentOffer
		commitmentID = params[:commitmentID].gsub(/\s|"|'/, '')
		sourceID = params['messenger user id']

		ent = Individual.find_by(sourceID: sourceID)
		puts commitmentID
		com = Commitment.find_by(id: commitmentID)
		puts ent
		puts com
		if !com.nil? && !ent.nil? && com.entreprenuer_id == ent.id #Correct entrepreneur, just to ensure that the individual is not doing anything to break the application
			puts "Attempt to send acceptance confirmation"
			cs = CommitmentStatus.find_by(statusName: 'offerAccepted')
			com.commitmentStatus_id = cs.id
			entName = "#{ent.firstName} #{ent.lastName}"
			helperID = com.helper_id
			SendCommitmentAcceptanceToHelper(entName, com.id, helperID)
			com.save
		end

		render html: "Pass"
	end

	def RejectCommitmentOffer
		commitmentID = params[:commitmentID].gsub(/\s|"|'/, '')
		sourceID = params['messenger user id']

		ent = Individual.find_by(sourceID: sourceID)
		com = Commitment.find_by(id: commitmentID)
		if !com.nil? && !ent.nil? && com.entreprenuer_id == ent.id #Correct entrepreneur, just to ensure that the individual is not doing anything to break the application
			puts "Attempt to send rejection of offer"
			cs = CommitmentStatus.find_by(statusName: 'offerRejected')
			com.commitmentStatus_id = cs.id
			entName = "#{ent.firstName} #{ent.lastName}"
			helperID = com.helper_id
			SendCommitmentRejectionToHelper(entName, com.id, helperID)
			com.save
		end

		render html: "Pass"
	end

	def PromptCommitmentComplete
		commitmentID = params[:commitmentIDToComplete].gsub(/\s|"|'/, '')
		sourceID = params['messenger user id']

		helper = Individual.find_by(sourceID: sourceID)
		com = Commitment.find_by(id: commitmentID)
		if !com.nil? && !helper.nil? && com.helper_id == helper.id
			cs = CommitmentStatus.find_by(statusName: 'completionRequest')
			com.commitmentStatus_id = cs.id
			helperName = "#{helper.firstName} #{helper.lastName}"
			entID = com.entreprenuer_id
			SendCommitmentCompletionPrompt(helperName, com.id, entID)
			com.save
		end

		render html: "Pass"
	end

	def AcceptCommitmentCompletion
		commitmentID = params[:commitmentID].gsub(/\s|"|'/, '')
		sourceID = params['messenger user id']

		ent = Individual.find_by(sourceID: sourceID)
		com = Commitment.find_by(id: commitmentID)
		if !com.nil? && !ent.nil? && com.entreprenuer_id == ent.id
			puts "Attempting to Send Acceptance"
			cs = CommitmentStatus.find_by(statusName: 'completionAccepted')
			com.commitmentStatus_id = cs.id
			entName = "#{ent.firstName} #{ent.lastName}"
			helperID = com.helper_id
			SendCommitmentCompletionAcceptance(entName, com.id, helperID)
			com.save
		end

		render html: "Pass"
	end

	def RejectCommitmentCompletion
		commitmentID = params[:commitmentID].gsub(/\s|"|'/, '')
		sourceID = params['messenger user id']

		ent = Individual.find_by(sourceID: sourceID)
		com = Commitment.find_by(id: commitmentID)
		if !com.nil? && !ent.nil? && com.entreprenuer_id == ent.id
			puts "Attempting to Send Acceptance"
			cs = CommitmentStatus.find_by(statusName: 'completionRejected')
			com.commitmentStatus_id = cs.id
			entName = "#{ent.firstName} #{ent.lastName}"
			helperID = com.helper_id
			SendCommitmentCompletionRejection(entName, com.id, helperID)
			com.save
		end

		render html: "Pass"
	end

end
