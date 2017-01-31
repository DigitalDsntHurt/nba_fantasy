class TeamYear < ApplicationRecord
	has_many :players
	has_many :player_games
end
