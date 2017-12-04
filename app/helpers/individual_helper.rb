module IndividualHelper

	def RegisterIndividual(firstName, lastName, source, sourceID, email)
		puts "Attempting to register"
		if !Individual.exists?(sourceID: sourceID)
			puts "Individual Does not exist"
			user = Individual.new(source: source, sourceID: sourceID, firstName: firstName, lastName: lastName, email:email)
			user.save
		end
	end

end
