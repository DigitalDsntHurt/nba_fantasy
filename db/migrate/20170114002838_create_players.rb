class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :year_of_birth
      t.string :position_br
      t.string :position_dk
      t.string :current_team
      t.text :team_history
      t.float :points_season_avg
      t.float :points_career_avg
      t.float :three_pt_shots_made_season_avg
      t.float :three_pt_shots_made_career_avg
      t.float :assists_season_avg
      t.float :assists_career_avg
      t.float :offensive_rebounds_season_avg
      t.float :defensive_rebounds_season_avg
      t.float :offensive_rebounds_career_avg
      t.float :defensive_rebounds_career_avg
      t.float :steals_season_avg
      t.float :steals_career_avg
      t.float :blocks_season_avg
      t.float :blocks_career_avg
      t.float :turnovers_season_avg
      t.float :turnovers_career_avg
      t.boolean :active

      t.timestamps
    end
  end
end
