class IndividualController < ApplicationController
	skip_before_filter :verify_authenticity_token
	skip_before_action :verify_authenticity_token

	def RegisterFacebookIndividual
		RegisterIndividual(params['first name'], params['last name'], 'FB', params['messenger user id'], '')
		render html: "Pass"
	end
end
