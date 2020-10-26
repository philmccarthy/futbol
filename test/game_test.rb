require './test/test_helper'
require './lib/game'
class GameTest < Minitest::Test
  def setup
    @game = Game.new({
      game_id: 2012030221,
      season: "20122013",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3,
    })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
    assert_equal 2012030221, @game.id
    assert_equal "20122013", @game.season
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end
end
