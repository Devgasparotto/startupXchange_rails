Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'utility#index'

  #Chatfuel Controller
  get "/isValidCommitmentDate/", to: "chatfuel#IsValidCommitmentDate"

  #Individual Controller
  post "/registerFacebookIndividual/", to: "individual#RegisterFacebookIndividual"

  #Helper Controller
  post "/SetIndividualAsHelper/", to: "helper#SetIndividualAsHelper"
  post "/GetReliabilityRating/", to: "helper#GetReliabilityRating"

  #Entrepreneur Controller
  post "/SetIndividualAsEntrepreneur/", to: "entrepreneur#SetIndividualAsEntrepreneur"
  post "/IsValidEntrepreneur/", to: "entrepreneur#IsValidEntrepreneur"

  #Commitment Controller
  post "/CreateCommitment/", to: "commitment#CreateCommitment"
  get "/ViewCommitments/", to: "commitment#ViewCommitments"
  post "/AcceptCommitmentOffer/", to: "commitment#AcceptCommitmentOffer"
  post "/RejectCommitmentOffer/", to: "commitment#RejectCommitmentOffer"
  post "/PromptCommitmentComplete/", to: "commitment#PromptCommitmentComplete"
  post "/AcceptCommitmentCompletion/", to: "commitment#AcceptCommitmentCompletion"
  post "/RejectCommitmentCompletion/", to: "commitment#RejectCommitmentCompletion"

  #Test
  get "/PrepopulateCommitmentStatuses", to: "commitment#PrepopulateCommitmentStatuses"




end
