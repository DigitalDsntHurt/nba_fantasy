require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get players_url
    assert_response :success
  end

  test "should get new" do
    get new_player_url
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post players_url, params: { player: { assists_career_avg: @player.assists_career_avg, assists_season_avg: @player.assists_season_avg, blocks_career_avg: @player.blocks_career_avg, blocks_season_avg: @player.blocks_season_avg, current_team: @player.current_team, defensive_rebounds_career_avg: @player.defensive_rebounds_career_avg, defensive_rebounds_season_avg: @player.defensive_rebounds_season_avg, name: @player.name, offensive_rebounds_career_avg: @player.offensive_rebounds_career_avg, offensive_rebounds_season_avg: @player.offensive_rebounds_season_avg, points_career_avg: @player.points_career_avg, points_season_avg: @player.points_season_avg, position_br: @player.position_br, position_dk: @player.position_dk, steals_career_avg: @player.steals_career_avg, steals_season_avg: @player.steals_season_avg, team_history: @player.team_history, three_pt_shots_made_career_avg: @player.three_pt_shots_made_career_avg, three_pt_shots_made_season_avg: @player.three_pt_shots_made_season_avg, turnovers_career_avg: @player.turnovers_career_avg, turnovers_season_avg: @player.turnovers_season_avg, year_of_birth: @player.year_of_birth } }
    end

    assert_redirected_to player_url(Player.last)
  end

  test "should show player" do
    get player_url(@player)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_url(@player)
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { assists_career_avg: @player.assists_career_avg, assists_season_avg: @player.assists_season_avg, blocks_career_avg: @player.blocks_career_avg, blocks_season_avg: @player.blocks_season_avg, current_team: @player.current_team, defensive_rebounds_career_avg: @player.defensive_rebounds_career_avg, defensive_rebounds_season_avg: @player.defensive_rebounds_season_avg, name: @player.name, offensive_rebounds_career_avg: @player.offensive_rebounds_career_avg, offensive_rebounds_season_avg: @player.offensive_rebounds_season_avg, points_career_avg: @player.points_career_avg, points_season_avg: @player.points_season_avg, position_br: @player.position_br, position_dk: @player.position_dk, steals_career_avg: @player.steals_career_avg, steals_season_avg: @player.steals_season_avg, team_history: @player.team_history, three_pt_shots_made_career_avg: @player.three_pt_shots_made_career_avg, three_pt_shots_made_season_avg: @player.three_pt_shots_made_season_avg, turnovers_career_avg: @player.turnovers_career_avg, turnovers_season_avg: @player.turnovers_season_avg, year_of_birth: @player.year_of_birth } }
    assert_redirected_to player_url(@player)
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete player_url(@player)
    end

    assert_redirected_to players_url
  end
end
