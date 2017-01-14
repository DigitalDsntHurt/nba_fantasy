class Player < ApplicationRecord
	serialize :team_history, Array
end
