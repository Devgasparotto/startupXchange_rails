class HelperController < ApplicationController

	def SetIndividualAsHelper
		ind = Individual.find_by sourceID: params['messenger user id']
		if !ind.nil?
			ind.isHelper = 1
			ind.isEntreprenuer = 0
		end
	end
end
