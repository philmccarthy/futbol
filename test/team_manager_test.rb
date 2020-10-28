require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/team_manager'

class TeamManagerTest < Minitest::Test

  def setup
    @team_manager = TeamManager.new('./data/teams.csv')
    @team_manager.all
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TeamManager, @team_manager
    assert_equal './data/teams.csv', @team_manager.teams_data
  end

  def test_it_gives_array_of_all_teams
    assert_equal Team,  @team_manager.teams.first.class
  end

  def test_team_info
    expected = {
                "team_id" => "18",
                "franchise_id" => "34",
                "team_name" => "Minnesota United FC",
                "abbreviation" => "MIN",
                "link" => "/api/v1/teams/18"
              }
    assert_equal expected, @team_manager.team_info("18")
  end

  def test_count_of_teams
    assert_equal 32, @team_manager.count_of_teams
  end
end
