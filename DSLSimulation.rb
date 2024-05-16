require 'csv'

class HitTypes
  attr_accessor :homeruns, :triples, :doubles, :singles

  def initialize
    @homeruns = 0
    @triples = 0
    @doubles = 0
    @singles = 0
  end
end

class GameStats
  attr_accessor :game_number, :runs_scored, :inning_data, :player_stats

  def initialize(game_number)
    @game_number = game_number
    @runs_scored = 0
    @inning_data = 0
    @player_stats = {}
  end

  def add_game(game_number, runs, inning_data, player_stats)
    @game_number = game_number
    @runs_scored = runs
    @inning_data = inning_data
    @player_stats = player_stats
  end
end

class Simulation
  attr_reader :game_results
  def initialize
    @game_results = []
  end
end

cass = [
  {name: "Smith, Chuck", g: 8, ab: 30, r: 16, h: 22, singles: 3, doubles: 11, triples: 4, hr: 4, rbi: 19, k: 0, tb: 53, sac: 0, gwrbi: 0, avg: 0.733, obp: 0.733, slg: 1.767, ops: 2.5},
  {name: "Tysdal, Jory", g: 8, ab: 29, r: 18, h: 23, singles: 9, doubles: 7, triples: 3, hr: 4, rbi: 15, k: 0, tb: 48, sac: 0, gwrbi: 0, avg: 0.793, obp: 0.793, slg: 1.655, ops: 2.448},
  {name: "Rodriguez, Ruben", g: 6, ab: 21, r: 13, h: 17, singles: 5, doubles: 8, triples: 0, hr: 4, rbi: 22, k: 0, tb: 37, sac: 1, gwrbi: 0, avg: 0.81, obp: 0.773, slg: 1.762, ops: 2.535},
  {name: "Sosa, Angel", g: 8, ab: 23, r: 15, h: 17, singles: 2, doubles: 3, triples: 2, hr: 10, rbi: 25, k: 0, tb: 54, sac: 3, gwrbi: 0, avg: 0.739, obp: 0.654, slg: 2.348, ops: 3.002},
  {name: "Melody, Ali", g: 8, ab: 31, r: 13, h: 19, singles: 11, doubles: 5, triples: 2, hr: 1, rbi: 14, k: 0, tb: 31, sac: 0, gwrbi: 0, avg: 0.613, obp: 0.613, slg: 1.0, ops: 1.613},
  {name: "Shin, Nico", g: 7, ab: 24, r: 14, h: 19, singles: 5, doubles: 8, triples: 2, hr: 4, rbi: 20, k: 0, tb: 43, sac: 1, gwrbi: 0, avg: 0.792, obp: 0.76, slg: 1.792, ops: 2.552},
  {name: "Greenough, Jason", g: 8, ab: 27, r: 12, h: 22, singles: 6, doubles: 5, triples: 8, hr: 3, rbi: 23, k: 0, tb: 52, sac: 0, gwrbi: 1, avg: 0.815, obp: 0.815, slg: 1.926, ops: 2.741},
  {name: "Mallick, Rushda", g: 8, ab: 23, r: 6, h: 12, singles: 11, doubles: 1, triples: 0, hr: 0, rbi: 6, k: 0, tb: 13, sac: 0, gwrbi: 0, avg: 0.522, obp: 0.522, slg: 0.565, ops: 1.087},
  {name: "Miller, Todd", g: 7, ab: 27, r: 15, h: 21, singles: 9, doubles: 8, triples: 2, hr: 2, rbi: 13, k: 0, tb: 39, sac: 0, gwrbi: 0, avg: 0.778, obp: 0.778, slg: 1.444, ops: 2.222},
  {name: "Groba, Paul", g: 8, ab: 25, r: 7, h: 19, singles: 14, doubles: 5, triples: 0, hr: 0, rbi: 7, k: 0, tb: 24, sac: 0, gwrbi: 0, avg: 0.76, obp: 0.76, slg: 0.96, ops: 1.72},
  {name: "Mesta, Dalila", g: 8, ab: 29, r: 7, h: 19, singles: 17, doubles: 1, triples: 0, hr: 1, rbi: 8, k: 1, tb: 23, sac: 0, gwrbi: 0, avg: 0.655, obp: 0.655, slg: 0.793, ops: 1.448},
  {name: "Henry, Robert", g: 6, ab: 21, r: 8, h: 14, singles: 6, doubles: 6, triples: 0, hr: 2, rbi: 8, k: 0, tb: 26, sac: 0, gwrbi: 0, avg: 0.667, obp: 0.667, slg: 1.238, ops: 1.905},
  {name: "Dwan, Shane", g: 8, ab: 25, r: 13, h: 18, singles: 10, doubles: 2, triples: 3, hr: 3, rbi: 10, k: 0, tb: 35, sac: 1, gwrbi: 0, avg: 0.72, obp: 0.692, slg: 1.4, ops: 2.092}
]

hite = [
  {name: "Thomas, Zach", g: 8, ab: 29, r: 19, h: 25, singles: 8, doubles: 6, triples: 6, hr: 5, rbi: 24, k: 0, tb: 58, sac: 0, gwrbi: 0, avg: 0.862, obp: 0.862, slg: 2.0, ops: 2.862},
  {name: "Wickham, Will", g: 7, ab: 25, r: 13, h: 20, singles: 10, doubles: 5, triples: 4, hr: 1, rbi: 10, k: 0, tb: 36, sac: 0, gwrbi: 0, avg: 0.8, obp: 0.8, slg: 1.44, ops: 2.24},
  {name: "Whitacre, Paul", g: 8, ab: 30, r: 18, h: 24, singles: 9, doubles: 7, triples: 4, hr: 4, rbi: 22, k: 1, tb: 51, sac: 0, gwrbi: 0, avg: 0.8, obp: 0.8, slg: 1.7, ops: 2.5},
  {name: "Bergan, Derek", g: 8, ab: 30, r: 12, h: 26, singles: 7, doubles: 12, triples: 4, hr: 3, rbi: 30, k: 0, tb: 55, sac: 2, gwrbi: 1, avg: 0.867, obp: 0.813, slg: 1.833, ops: 2.646},
  {name: "Louw, Johan", g: 7, ab: 22, r: 12, h: 17, singles: 8, doubles: 3, triples: 3, hr: 3, rbi: 18, k: 0, tb: 35, sac: 3, gwrbi: 0, avg: 0.773, obp: 0.68, slg: 1.591, ops: 2.271},
  {name: "Campbell, Matthew", g: 8, ab: 29, r: 10, h: 21, singles: 13, doubles: 6, triples: 2, hr: 0, rbi: 10, k: 1, tb: 31, sac: 0, gwrbi: 2, avg: 0.724, obp: 0.724, slg: 1.069, ops: 1.793},
  {name: "Walker, Quinn", g: 8, ab: 29, r: 12, h: 25, singles: 13, doubles: 9, triples: 2, hr: 1, rbi: 18, k: 0, tb: 41, sac: 0, gwrbi: 0, avg: 0.862, obp: 0.862, slg: 1.414, ops: 2.276},
  {name: "Skrezyna, Dan", g: 7, ab: 27, r: 19, h: 24, singles: 16, doubles: 8, triples: 0, hr: 0, rbi: 9, k: 0, tb: 32, sac: 0, gwrbi: 0, avg: 0.889, obp: 0.889, slg: 1.185, ops: 2.074},
  {name: "Stolker, Joscelyn", g: 8, ab: 30, r: 4, h: 21, singles: 20, doubles: 1, triples: 0, hr: 0, rbi: 5, k: 1, tb: 22, sac: 0, gwrbi: 0, avg: 0.7, obp: 0.7, slg: 0.733, ops: 1.433},
  {name: "Warner, Tim", g: 8, ab: 31, r: 18, h: 26, singles: 16, doubles: 5, triples: 3, hr: 2, rbi: 21, k: 0, tb: 43, sac: 1, gwrbi: 0, avg: 0.839, obp: 0.813, slg: 1.387, ops: 2.2},
  {name: "Gonnella, Chris", g: 8, ab: 34, r: 22, h: 27, singles: 20, doubles: 4, triples: 0, hr: 3, rbi: 17, k: 0, tb: 40, sac: 0, gwrbi: 1, avg: 0.794, obp: 0.794, slg: 1.176, ops: 1.971},
  {name: "Brittany, Haley", g: 6, ab: 21, r: 4, h: 11, singles: 10, doubles: 1, triples: 0, hr: 0, rbi: 5, k: 0, tb: 12, sac: 0, gwrbi: 0, avg: 0.524, obp: 0.524, slg: 0.571, ops: 1.095},
  {name: "Hartman, April", g: 6, ab: 21, r: 6, h: 13, singles: 9, doubles: 4, triples: 0, hr: 0, rbi: 8, k: 0, tb: 17, sac: 2, gwrbi: 0, avg: 0.619, obp: 0.565, slg: 0.81, ops: 1.375}

]





def playBall(lineup, team_name, output_file)


player_stats = {}
game_stats_list = []

total_runs_scored = 0
total_hits = 0
total_rbi = 0

num_simulations = 1000


# Simulate the game
inning_data = []
runs_scored = 0
hits = 0
game = 0
hit_types = HitTypes.new
current_batter_index = 0

# Define a function to simulate an at-bat
def simulate_at_bat(player)
  random_number = rand
  random_number <= (player[:avg] * 0.7)
end

def determine_hit_type(player, hit_types)
  hit_probability = rand
  player_hits = player[:singles] + player[:doubles] + player[:triples] + player[:hr]
  if hit_probability < (player[:hr] / player_hits.to_f)
    hit_types.homeruns += 1
    return 4
  elsif hit_probability < ((player[:triples] + player[:hr]) / player_hits.to_f)
    hit_types.triples += 1
    return 3
  elsif hit_probability < ((player[:hr] + player[:triples] + player[:doubles]) / player_hits.to_f)
    hit_types.doubles += 1
    return 2
  else
    hit_types.singles += 1
    return 1
  end
end


num_simulations.times do |simulation|
# Simulate the game
  game += 1
  game_number = simulation + 1
  game_stats = GameStats.new(simulation)
  inning_data = []
  inning = 0
  runs_scored = 0
  hits = 0
  current_batter_index = 0
  # puts "Game # #{game} #{team_name}"
  # puts "--------------"
7.times do |inning|
  
  outs = 0
  inning_hits = 0
  inning_runs = 0
  bases = [0, 0, 0]  # Represents first, second, and third base, 0 for empty, 1 for occupied
  # current_batter_index = 0
  # p "Inning = #{inning + 1}"
  
  while outs < 3
    player = lineup[current_batter_index]
    current_batter = player[:name]
    player_stats[current_batter] ||= { singles: 0, doubles: 0, triples: 0, rbi: 0, hr: 0, ab: 0 }  # Initialize player stats if not already present
    
    at_bat_outcome = simulate_at_bat(player) ? determine_hit_type(player, hit_types) : 0
    # puts "#{player[:name]}: #{at_bat_outcome}"
    player_stats[current_batter][:ab] += 1
    if at_bat_outcome > 0
      inning_hits += 1
      hits += 1
     
if at_bat_outcome > 0
  # A hit occurred
  case at_bat_outcome
  when 1
    # Single
    player_stats[current_batter][:singles] += 1
    
    (1..2).each do |base| 
      inning_runs += bases[base]
      runs_scored += bases[base] 
      if bases[base] == 1 
        player_stats[current_batter][:rbi] += 1
        total_rbi += 1
      end
      bases[base] = 0
      # puts "Runs: #{inning_runs}" 
    end
    if bases[0] == 1
      random_number = rand
      # puts random_number
      if random_number > 0.67
        bases[2] = 1
      elsif random_number > 0.33
        bases[1] = 1
      elsif random_number > 0.29
        outs += 2
        bases[1] = 0
        # puts "DOUBLE PLAY"
      else
        outs += 1
        # p "Outs: #{outs}"
      end
    end
      # Runner reaches first
      bases[0] = 1
  when 2
    # Double
    player_stats[current_batter][:doubles] += 1

    (0..2).each do |base| 
      inning_runs += bases[base]
      runs_scored += bases[base] 
      if bases[base] == 1 
        player_stats[current_batter][:rbi] += 1
        total_rbi += 1

      end
      # puts "Runs: #{inning_runs}" 
    end
    bases[0] = 0  # Runner on first advances to second
    bases[1] = 1  # Runner reaches second
    bases[2] = 0
    
  when 3
    # Triple
    player_stats[current_batter][:triples] += 1

    (0..2).each do |base| 
      inning_runs += bases[base]
      runs_scored += bases[base] 
      if bases[base] == 1 
        player_stats[current_batter][:rbi] += 1
        total_rbi += 1

      end
      # puts "Runs: #{inning_runs}" 
    end  # Increment runs for each baserunner
    bases[0] = 0  # Runner on first advances to third
    bases[1] = 0  # Runner on second advances to third
    bases[2] = 1  # Runner reaches third
    
  when 4
    player_stats[current_batter][:hr] += 1
    player_stats[current_batter][:rbi] += 1
    total_rbi += 1
    # Home Run
    inning_runs += 1   # Increment runs scored for the inning
    runs_scored += 1   # Increment total runs scored
    (0..2).each do |base| 
      inning_runs += bases[base]
      runs_scored += bases[base] 
      if bases[base] == 1 
        player_stats[current_batter][:rbi] += 1
        total_rbi += 1
      end
      # puts "Runs: #{inning_runs}" 
    end  # Increment runs for each baserunner
    bases = [0, 0, 0]  # Clear all bases
    
  end
  # puts "Bases: #{bases}"
else
  # No hit, an out occurred
  outs += 1
  # puts "Bases: #{bases}"
end 
    else
      outs += 1
      # p "#{player[:name]} out #{outs}"
      break if outs == 3
    end
    current_batter_index = (current_batter_index + 1) % lineup.length
  end
  # puts "Inning Over"
  inning_data << { hits: inning_hits, runs: inning_runs }
  # puts "Runs Scored: #{inning_data[inning][:runs]}, Hits: #{inning_data[inning][:hits]}"
  # puts "--------------"
end

game_stats.add_game(game_number, runs_scored, inning_data, player_stats)

inning = 0
inning_data = []
player_stats = {}

# Display game results
# puts "Game Results:"
# inning_data.each_with_index do |inning_result, i|
#   puts "Inning #{i + 1}: Runs Scored: #{inning_result[:runs]}, Hits: #{inning_result[:hits]}"
# end



# puts "Total Runs: #{runs_scored}, Total Hits: #{hits}"
# puts "Homers: #{hit_types.homeruns}, Triples: #{hit_types.triples}, Doubles: #{hit_types.doubles}, Singles: #{hit_types.singles}"

  total_runs_scored += runs_scored
  total_hits += hits
  
  game_stats_list << game_stats

end


average_runs_scored = total_runs_scored.to_f / num_simulations
average_hits = total_hits.to_f / num_simulations

# puts "Total Runs: #{total_runs_scored}"

# puts "Average runs scored: #{average_runs_scored}"
# puts "Average Hits: #{average_hits}"



# player_stats.each do |player|
#   puts "Player: #{player[0]}"
#   puts "Statistics:"
#   puts "  Singles: #{player[1][:singles].to_f / num_simulations}"
#   puts "  Doubles: #{player[1][:doubles].to_f / num_simulations}"
#   puts "  Triples: #{player[1][:triples].to_f / num_simulations}"
#   puts "  Home Runs: #{player[1][:hr].to_f / num_simulations}"
#   puts "  RBI: #{player[1][:rbi].to_f / num_simulations}"
#   puts "  At-bats: #{player[1][:ab].to_f / num_simulations}"
#   puts "  AVG: #{(player[1][:singles] + player[1][:doubles] + player[1][:triples] + player[1][:hr]) / player[1][:ab].to_f}"
#   puts "---------------------------------------"
# end


# puts "Total Runs: #{total_runs_scored}"


 puts "Average runs scored: #{team_name} #{average_runs_scored}"
# puts "Average Hits: #{average_hits}"
 
# puts "#{ game_stats_list.each_with_index  do |game_stat, index| puts "#{index + 1} #{game_stat.runs_scored}" end}"

results = Simulation.new
results.game_results.push(*game_stats_list)


CSV.open(output_file, 'w') do |csv|
  # Write header row
  csv << ['Game Number', 'Runs Scored', 'Inning Data', 'Player Stats']

  results.game_results.each do |game|
    # Prepare data for CSV
    game_number = game.game_number
    runs_scored = game.runs_scored
    inning_data = game.inning_data.to_s
    player_stats = game.player_stats.to_s

    # Write data to CSV
    csv << [game_number, runs_scored, inning_data, player_stats]
 
  end
end


end

playBall(cass, "Cass", 'cass.csv')
playBall(hite, "Hite", 'hite.csv')