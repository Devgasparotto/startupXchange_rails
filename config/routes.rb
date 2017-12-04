Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'utility#index'

  #Chatfuel Controller
  get "/isValidCommitmentDate/", to: "chatfuel#IsValidCommitmentDate" 

end
