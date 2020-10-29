require './test/test_helper'
require './lib/game'
require './lib/game_manager'

class GameManagerTest < Minitest::Test
  def setup
    @game_manager = GameManager.new('./data/games.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameManager, @game_manager
    assert_equal Array, @game_manager.games.class
  end

  def test_it_can_add_array_of_all_game_objects
    assert_instance_of Game, @game_manager.games.first
  end

  def test_it_calculates_highest_total_score
    assert_equal 11, @game_manager.highest_total_score
  end

  def test_it_calculates_lowest_total_score
    assert_equal 0, @game_manager.lowest_total_score
  end

  def test_it_gives_percentage_of_home_wins
    assert_equal 0.44, @game_manager.percentage_home_wins
  end

  def test_it_gives_percentage_of_visitor_wins
    assert_equal 0.36, @game_manager.percentage_visitor_wins
  end

  def test_it_gives_percentage_of_ties
    assert_equal 0.20, @game_manager.percentage_ties
  end

  def test_it_gives_game_count
    assert_equal 806, @game_manager.game_count("20122013")
  end

  def test_it_gives_games_by_season_count
    expected = {
                "20122013"=>806,
                "20162017"=>1317,
                "20142015"=>1319,
                "20152016"=>1321,
                "20132014"=>1323,
                "20172018"=>1355
              }
    assert_equal expected, @game_manager.count_of_games_by_season
  end

  def test_it_gives_average_goals_per_game
    assert_equal 4.22, @game_manager.average_goals_per_game
  end

  def test_it_gives_goal_count_by_season
    assert_equal 3322, @game_manager.goal_count('20122013')

  end

  def test_it_gives_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, @game_manager.average_goals_by_season
  end
end
