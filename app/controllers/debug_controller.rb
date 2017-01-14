class DebugController < ApplicationController
  def index

  	@team_years = TeamYear.all
  	@players = Player.all
  end
end
