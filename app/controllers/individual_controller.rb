class IndividualController < ApplicationController
	def RegisterFacebookIndividual
		RegisterIndividual(params['first name'], params['last name'], 'FB', params['messenger user id'], '')
		render html: "Pass"
	end
end
