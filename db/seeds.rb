# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CommitmentStatus.create(statusName: 'offerSent', statusDescription: 'Helper has sent a commitment offer to an entrepreneur')
CommitmentStatus.create(statusName: 'offerAccepted', statusDescription: 'Entrepreneur has accepted helpers offer of help')
CommitmentStatus.create(statusName: 'offerRejected', statusDescription: 'Entrepreneur has rejected helpers offer of help')
CommitmentStatus.create(statusName: 'completionRequest', statusDescription: 'Helper indicates commitment is complete')
CommitmentStatus.create(statusName: 'completionRejected', statusDescription: 'Entrepreneur rejects commitment completion')
CommitmentStatus.create(statusName: 'completionAccepted', statusDescription: 'Entrepreneur accepts commitment completion')

