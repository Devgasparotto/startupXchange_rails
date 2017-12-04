module IndividualHelper

	def RegisterIndividual(firstName, lastName, source, sourceID, email)
		if !Individual.exists?(sourceID: sourceID)
			user = Individual.new(source: source, sourceID: sourceID, firstName: firstName, lastName: lastName, email:email)
			user.save
		end
	end

end
