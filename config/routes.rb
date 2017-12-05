Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'utility#index'

  #Chatfuel Controller
  get "/isValidCommitmentDate/", to: "chatfuel#IsValidCommitmentDate"

  #Individual Controller
  post "/registerFacebookIndividual/", to: "individual#RegisterFacebookIndividual"

  #Helper Controller
  post "/SetIndividualAsHelper/", to: "helper#SetIndividualAsHelper"

  #Entrepreneur Controller
  post "/SetIndividualAsEntrepreneur/", to: "entrepreneur#SetIndividualAsEntrepreneur"
  post "/IsValidEntrepreneur/", to: "entrepreneur#IsValidEntrepreneur"

  #Commitment Controller
  post "/CreateCommitment/", to: "commitment#CreateCommitment"
end
