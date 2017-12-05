class CommitmentController < ApplicationController
	skip_before_action :verify_authenticity_token

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
						com = Commitment.new(helper_id: ind.id, entreprenuer_id: entrepreneurID, commitmentOffer: commitmentOffer, commitmentDueDate: inputDate, commitmentStatus_id: 1)
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
	      commitments = Commitments.where(helper_id: params['messenger user id']).to_a
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
end
