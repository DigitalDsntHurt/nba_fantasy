require 'test_helper'

class PlayerGamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_game = player_games(:one)
  end

  test "should get index" do
    get player_games_url
    assert_response :success
  end

  test "should get new" do
    get new_player_game_url
    assert_response :success
  end

  test "should create player_game" do
    assert_difference('PlayerGame.count') do
      post player_games_url, params: { player_game: { ast: @player_game.ast, blk: @player_game.blk, date: @player_game.date, drb: @player_game.drb, fg: @player_game.fg, fga: @player_game.fga, fgp: @player_game.fgp, ft: @player_game.ft, fta: @player_game.fta, ftp: @player_game.ftp, minutes_played: @player_game.minutes_played, opponent_id: @player_game.opponent_id, orb: @player_game.orb, pf: @player_game.pf, player_id: @player_game.player_id, pts: @player_game.pts, stl: @player_game.stl, team_id: @player_game.team_id, threep: @player_game.threep, threepa: @player_game.threepa, threepp: @player_game.threepp, tov: @player_game.tov, trb: @player_game.trb } }
    end

    assert_redirected_to player_game_url(PlayerGame.last)
  end

  test "should show player_game" do
    get player_game_url(@player_game)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_game_url(@player_game)
    assert_response :success
  end

  test "should update player_game" do
    patch player_game_url(@player_game), params: { player_game: { ast: @player_game.ast, blk: @player_game.blk, date: @player_game.date, drb: @player_game.drb, fg: @player_game.fg, fga: @player_game.fga, fgp: @player_game.fgp, ft: @player_game.ft, fta: @player_game.fta, ftp: @player_game.ftp, minutes_played: @player_game.minutes_played, opponent_id: @player_game.opponent_id, orb: @player_game.orb, pf: @player_game.pf, player_id: @player_game.player_id, pts: @player_game.pts, stl: @player_game.stl, team_id: @player_game.team_id, threep: @player_game.threep, threepa: @player_game.threepa, threepp: @player_game.threepp, tov: @player_game.tov, trb: @player_game.trb } }
    assert_redirected_to player_game_url(@player_game)
  end

  test "should destroy player_game" do
    assert_difference('PlayerGame.count', -1) do
      delete player_game_url(@player_game)
    end

    assert_redirected_to player_games_url
  end
end
