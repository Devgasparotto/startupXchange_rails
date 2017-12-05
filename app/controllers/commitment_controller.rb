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
						com = Commitment.new(helper_id: ind.id, entreprenuer_id: entrepreneurID, commitmentOffer: commitmentOffer, commitmentDueDate: inputDate, commitmentStatus_id: 1)
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
	      puts Commitment.where(helper_id: ind.id)
	      commitments = Commitment.where(helper_id: ind.id).to_a
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
	                block_name: "Helper Hub",
	                set_attributes: {
	                  currentCommitmentID: "#{commitments[j].id}"
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
		commitmentID = params[:commitmentID]
		sourceID = params['messenger user id']

		ent = Individual.find_by(sourceID: sourceID)
		com = Commitment.find_by(id: commitmentID)
		if !com.nil? && !ent.nil? && com.entreprenuer_id == ent.id #Correct entrepreneur, just to ensure that the individual is not doing anything to break the application
			entName = "#{ent.firstName} #{ent.lastName}"
			helperID = com.helper_id
			SendCommitmentAcceptanceToHelper(entName, com.id, helperID)
			puts "Offer sent"
		end

		render html: "Pass"
	end

end
