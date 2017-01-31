class DebugController < ApplicationController
  def index

  	@team_years = TeamYear.all
  	@players = Player.all
  	@player_games = PlayerGame.all
  end
end
