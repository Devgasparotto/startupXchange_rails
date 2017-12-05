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
end
