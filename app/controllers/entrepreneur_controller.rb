class EntrepreneurController < ApplicationController
	skip_before_action :verify_authenticity_token

	def SetIndividualAsEntrepreneur
		ind = Individual.find_by(sourceID: params['messenger user id'])
		puts ind
		if !ind.nil?
			ind.isHelper = 0
			ind.isEntreprenuer = 1
			ind.save
		end

		render html: "Pass"
	end

	def IsValidEntrepreneur
		expectedName = params[:inputName]
		expectedFirstLast = expectedName.split(' ')
		expectedFirst = expectedFirstLast[0]
		expectedLast = expectedFirstLast[1]
		isValid = false
		entrepreneurID = 0

		ent = Individual.find_by(firstName: expectedFirst, lastName: expectedLast) #? isEntreprenuer = 1?
		if !ent.nil? && !ent.empty?
			isValid = true
			entrepreneurID = ent.id
		end
		
		response = {
			"set_attributes": {
				"isValidEntrepreneur": "#{isValid}",
				"entrepreneurID": "#{entrepreneurID}"
			}
		}

		render json: response
	end
end
