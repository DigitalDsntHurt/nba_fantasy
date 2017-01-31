class CreateTeamYears < ActiveRecord::Migration[5.0]
  def change
    create_table :team_years do |t|
      t.integer :team_year_id
      t.string :year
      t.string :team
      t.integer :wins
      t.integer :losses
      t.string :win_percentage
      t.float :offensive_rating
      t.float :defensive_rating
      t.string :season_outcome
      t.string :team_url
      t.string :team_home_url

      t.timestamps
    end
  end
end
