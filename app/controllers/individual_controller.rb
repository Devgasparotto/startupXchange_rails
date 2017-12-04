class IndividualController < ApplicationController
	skip_before_action :verify_authenticity_token

	include IndividualHelper

	def RegisterFacebookIndividual
		RegisterIndividual(params['first name'], params['last name'], 'FB', params['messenger user id'], '')
		render html: "Pass" 
	end
end
