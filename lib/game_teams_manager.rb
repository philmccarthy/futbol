require 'csv'

class GameTeamsManager
  attr_reader :game_teams
  def initialize(file_location)
    all(file_location)
  end

  def all(file_location)
    game_teams_data = CSV.read(file_location, headers: true, header_converters: :symbol)
    @game_teams = game_teams_data.map do |game_team_data|
      GameTeam.new(game_team_data)
    end
  end

  def find_game_teams(home_or_away = nil)
    @game_teams.select do |game_team|
      if home_or_away     == 'home'
        game_team.hoa     == 'home'
      elsif home_or_away  == 'away'
        game_team.hoa     == 'away'
      else
        @game_teams
      end
    end
  end
    #
  def total_goals_by_team(home_or_away = nil)
    total_goals = Hash.new { |total_goals, id| total_goals[id] = 0 }
    find_game_teams(home_or_away).each do |game_team|
      total_goals[game_team.team_id] += game_team.goals
    end
    total_goals
  end

  def avg_goals_by_team(home_or_away = nil)
    avg_goals = {}
    total_goals_by_team(home_or_away).map do |team_id, goals|
      avg_goals[team_id] = (goals.to_f / game_count(team_id, home_or_away)).round(2)
    end
    avg_goals
  end

  def game_count(team_id, home_or_away = nil)
    sv = @game_teams.select do |game|
      if home_or_away == 'home'
        game.team_id == team_id && game.hoa == 'home'
      elsif home_or_away == 'away'
        game.team_id == team_id && game.hoa == 'away'
      else
        game.team_id == team_id
      end
    end.size
  end

  def best_offense
    avg_goals_by_team.max_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def worst_offense
    avg_goals_by_team.min_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def highest_scoring_visitor
    avg_goals_by_team('away').max_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def highest_scoring_home_team
    avg_goals_by_team('home').max_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def lowest_scoring_visitor
    avg_goals_by_team('away').min_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def lowest_scoring_home_team
    avg_goals_by_team('home').min_by do |team_id, average_goals|
      average_goals
    end.first
  end
end
