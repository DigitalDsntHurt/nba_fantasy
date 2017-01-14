Rails.application.routes.draw do
  
  #PLAYERGAMES

  # PLAYERS
  resources :players
  get 'players' => 'player#index'

  # TEAMYEARS
  resources :team_years

  # DEBUG
  get 'debug' => 'debug#index'

end
