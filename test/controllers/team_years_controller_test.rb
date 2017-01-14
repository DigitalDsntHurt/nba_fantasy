require 'test_helper'

class TeamYearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_year = team_years(:one)
  end

  test "should get index" do
    get team_years_url
    assert_response :success
  end

  test "should get new" do
    get new_team_year_url
    assert_response :success
  end

  test "should create team_year" do
    assert_difference('TeamYear.count') do
      post team_years_url, params: { team_year: { defensive_rating: @team_year.defensive_rating, losses: @team_year.losses, offensive_rating: @team_year.offensive_rating, season_outcome: @team_year.season_outcome, team: @team_year.team, team_home_url: @team_year.team_home_url, team_url: @team_year.team_url, win_percentage: @team_year.win_percentage, wins: @team_year.wins, year: @team_year.year } }
    end

    assert_redirected_to team_year_url(TeamYear.last)
  end

  test "should show team_year" do
    get team_year_url(@team_year)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_year_url(@team_year)
    assert_response :success
  end

  test "should update team_year" do
    patch team_year_url(@team_year), params: { team_year: { defensive_rating: @team_year.defensive_rating, losses: @team_year.losses, offensive_rating: @team_year.offensive_rating, season_outcome: @team_year.season_outcome, team: @team_year.team, team_home_url: @team_year.team_home_url, team_url: @team_year.team_url, win_percentage: @team_year.win_percentage, wins: @team_year.wins, year: @team_year.year } }
    assert_redirected_to team_year_url(@team_year)
  end

  test "should destroy team_year" do
    assert_difference('TeamYear.count', -1) do
      delete team_year_url(@team_year)
    end

    assert_redirected_to team_years_url
  end
end
