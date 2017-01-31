class CreatePlayerGames < ActiveRecord::Migration[5.0]
  def change
    create_table :player_games do |t|
      t.belongs_to :player, index: true, foreign_key: true
      t.belongs_to :team, foreign_key: true
      t.string :date
      t.belongs_to :opponent, foreign_key: true
      t.string :minutes_played
      t.integer :fg
      t.integer :fga
      t.float :fgp
      t.integer :threep
      t.integer :threepa
      t.float :threepp
      t.integer :ft
      t.integer :fta
      t.float :ftp
      t.integer :orb
      t.integer :drb
      t.integer :trb
      t.integer :ast
      t.integer :stl
      t.integer :blk
      t.integer :tov
      t.integer :pf
      t.integer :pts

      t.timestamps
    end
  end
end
