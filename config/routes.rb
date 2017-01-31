Rails.application.routes.draw do
  
  resources :player_games
  get 'console/index'

  #PLAYERGAMES

  # PLAYERS
  resources :players
  get 'players' => 'player#index'

  # TEAMYEARS
  resources :team_years

  # DEBUG
  get 'debug' => 'debug#index'
  get 'console' => 'console#index'

end
