class Player < ApplicationRecord
	serialize :team_history, Array
	belongs_to :team_year
	has_many :player_games, dependent: :destroy
	
end
