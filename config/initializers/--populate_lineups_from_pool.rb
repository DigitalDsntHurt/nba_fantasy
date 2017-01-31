=begin

##
#### Generate lineups w/ maximized expected fantasy points under a salary cap
##

start = Time.now

def calculate_total_salary(lineup)
	salary = 0
	lineup.each{|k,v|
		salary += v.salary unless k == :salary or k == :expected_fp
	}
	return salary
end

def calculate_total_fps(lineup)
	efps = 0.0
	lineup.each{|k,v|
		efps += v.fps unless k == :salary or k == :expected_fp
	}
	return efps
end

def legal?(lineup)
	if calculate_total_salary(lineup) > 50000
		return false
	else
		return true
	end
end

def calculate_total_salary_from_array(lineup)
	salary = 0
	lineup.each{|p|
		salary += p.salary
	}
	return salary
end

def calculate_total_fps_from_array(lineup)
	efps = 0.0
	lineup.each{|p|
		efps += p.fps
	}
	return efps
end

Rufus::Scheduler.new.every '90m', :first_in => '1s' do
	# if there are players in the pool and 
	# if there are no stored lineups
	if PlayerPool.all.count > 1 and Lineup.all.count < 1
	puts "============ BEGIN SCHEDULED LINEUP SELECTION ============"
	puts "============ SCHEDULER STARTED AT #{start} ============"
		#
		##
		## ### ### ### ### ### ### ### ### ### ##
		## ### ### ### ### ### ### ### ### ### ##
		## Set the # of generations to run	   ##
		   num_generations = 100  			   ##
							   				   ##		
		## Set the number of lineups desired   ##
		   num_lineups = 250				   ##
							   				   ##		   
		## set the salary cap 				   ##
			salary_cap = 50000	        	   ##
							   				   ##
		## ### ### ### ### ### ### ### ### ### ##
		## ### ### ### ### ### ### ### ### ### ##
		##
		#

=end

=begin
generations = {}
num_generations.times do |gen_num|

	# Get Eligible Players
	playerpool = PlayerPool.all
	players = []
	playerpool.each{|pp|
		players << Player.where(id: pp.player_id)[0] if pp.player_id != nil #|| pp.salary != nil
	}
	players.sort_by!{|p| -p.fps}.uniq!

	pgs = players.select{|p| p.position.include?("PG")}
	sgs = players.select{|p| p.position.include?("SG")}
	sfs = players.select{|p| p.position.include?("SF")}
	pfs = players.select{|p| p.position.include?("PF")}
	cs = players.select{|p| p.position.include?("C")}

	fs = players.select{|p| p.position.include?("F")}
	gs = players.select{|p| p.position.include?("G")}
	utils = players
	
	wildcards = utils.product(gs,fs).sort_by{ |p| -calculate_total_fps_from_array(p) }
	positionplayers = pgs.product(sgs,sfs,pfs,cs).uniq!.sort_by{ |p| -calculate_total_fps_from_array(p) }


def dynamic_programming_knapsack(problem)
  num_items = problem.items.size
  items = problem.items
  max_cost = problem.max_cost

  cost_matrix = zeros(num_items, max_cost+1)

  num_items.times do |i|
    (max_cost + 1).times do |j|
      if(items[i].cost > j)
        cost_matrix[i][j] = cost_matrix[i-1][j]
      else
        cost_matrix[i][j] = [cost_matrix[i-1][j], items[i].value + cost_matrix[i-1][j-items[i].cost]].max
      end
    end
  end

  cost_matrix
end

def get_used_items(problem, cost_matrix)
  i = cost_matrix.size - 1
  currentCost = cost_matrix[0].size - 1
  marked = Array.new(cost_matrix.size, 0) 

  while(i >= 0 && currentCost >= 0)
    if(i == 0 && cost_matrix[i][currentCost] > 0 ) || (cost_matrix[i][currentCost] != cost_matrix[i-1][currentCost])
      marked[i] = 1
      currentCost -= problem.items[i].cost
    end
    i -= 1
  end
  marked
end

 break if gen_num > 2
 puts "Generation #{gen_num} created in #{(Time.now-start)/60}"
end

	puts "============ SHESDULER TOOK #{(Time.now - start)/60} MINUTES TO RUN ============"
	puts "============ END SCHEDULER ============"
	end # mega if 
end #scheduler



=end


