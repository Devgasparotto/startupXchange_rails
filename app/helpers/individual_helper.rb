module IndividualHelper

	def RegisterIndividual(firstName, lastName, source, sourceID, email)
		if !Individual.exists?(sourceID: sourceID)
			user = Individual.new(source: source, sourceID: sourceID, firstName: firstName, lastName: lastName, email:email, isHelper: 0, isEntreprenuer: 0)
			user.save
		end
	end

end
