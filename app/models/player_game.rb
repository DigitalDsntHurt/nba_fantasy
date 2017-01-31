class PlayerGame < ApplicationRecord
	belongs_to :player
	#belongs_to :team_year
	belongs_to :opponent, :class_name => "TeamYear"
	belongs_to :team, :class_name => "TeamYear"
    
end
