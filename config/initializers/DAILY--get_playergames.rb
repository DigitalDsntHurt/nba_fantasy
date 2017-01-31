
scheduler = Rufus::Scheduler.new

#scheduler.cron '5 0 * * *' do
scheduler.in '1s' do
  
	def get_stuff_from_page(page,xpath)
		begin
		  request = RestClient::Resource.new(page, :verify_ssl => false).get
		rescue RestClient::NotFound => not_found
		  return not_found
		rescue 
		  return nil
		else
		  	payload = []
		  	Nokogiri::HTML(request).xpath(xpath).map{|item|
				payload << item.text.strip if item != nil
			}
			return payload
		end
	end

	start_date = Date.new(2014,10,28) 		

	##
	#### Get Yesterday's Game Results
	##
	base = "http://www.basketball-reference.com"
	yesterdays_games = base + "/boxscores/index.cgi?month=#{start_date.month}&day=#{start_date.day}&year=#{start_date.year}"
	xpath = "//div[@class='game_summary expanded nohover']/table[1]/tbody/tr/td/a | //div[@class='game_summary expanded nohover']/table[1]/tbody/tr/td/a/@href | //div[@class='game_summary expanded nohover']/table[1]/tbody/tr/td[@class='right']"

	@basic_results = get_stuff_from_page(yesterdays_games,xpath)
	@basic_results.reject!{|i| i.length < 2}.delete("Final")

	game_results = []
	until @basic_results.length < 1
		game_results << @basic_results.shift(7)
	end	

	@playergames = {}
	game_results.each{|r|
		@u = base+r[3]
		@away_team = r[1].gsub("/teams/","")[0..2].downcase
		@home_team = r[-2].gsub("/teams/","")[0..2].downcase
		@matchupteams = [ @away_team, @home_team ]
		@matchupteams.each{|team|
			@x = "//table[@id='box_#{team}_basic']/tbody/tr/th/a | //table[@id='box_#{team}_basic']/tbody/tr/td"
			@results = get_stuff_from_page(@u,@x)
			
			@team_playergames = []
			until @results.length < 1
				if @results[1] == "Did Not Play"
					@team_playergames << ( @results.shift(2).insert(1,@matchupteams.reject{|t| t == team}[0]).insert(1,start_date).insert(1,team) << ["","","","","","","","","","","","","","","","","",""] ).flatten
				else
					@team_playergames << @results.shift(20).insert(1,@matchupteams.reject{|t| t == team}[0]).insert(1,start_date).insert(1,team)
				end
			end

			@playergames[team] = @team_playergames
		}
	}

fuckedup = []

	@playergames.each{|k,val|
		puts "======"
		p k
		puts "======"
		val.each{|v|
			puts "___"
			p v
			p v[0]
			

			@yr = v[2].year.to_s + "-" + (v[2].year+1).to_s[-2..-1]
			@teams_of_year = TeamYear.where( year: @yr )
			@team_year_use = @teams_of_year.select{|toy| toy.team_url.downcase.include?(v[1]) }
			@opponent_year_use = @teams_of_year.select{|toy| toy.team_url.downcase.include?(v[3]) }
			@player = Player.where( name: v[0] )
			if @player.count != 1
				fuckedup << v
			else
				#@hsh_use = { :player => @player[0], :team_year_id => @team_year_use, :team_id => @team_year_use, :date => v[2], :opponent_id => @opponent_year_use, :minutes_played => v[-19], :fg => v[-18], :fga => v[-17], :fgp => v[-16], :threep => v[-15], :threepa => v[-14], :threepp => v[-13], :ft => v[-12], :fta => v[-11], :ftp =>  v[-10], :orb => v[-9], :drb => v[-8], :trb => v[-7], :ast => v[-6], :stl => v[-5], :blk => v[-4], :tov => v[-3], :pf => v[-2], :pts => v[-1] }
				@hsh_use = { :player => @player[0], :team => @team_year_use[0], :date => v[2], :opponent => @opponent_year_use[0], :minutes_played => v[-19], :fg => v[-18], :fga => v[-17], :fgp => v[-16], :threep => v[-15], :threepa => v[-14], :threepp => v[-13], :ft => v[-12], :fta => v[-11], :ftp =>  v[-10], :orb => v[-9], :drb => v[-8], :trb => v[-7], :ast => v[-6], :stl => v[-5], :blk => v[-4], :tov => v[-3], :pf => v[-2], :pts => v[-1] }
				PlayerGame.create!( @hsh_use )
				puts "Player Created!"
				p @hsh_use
				puts 
			end
		}
		puts 
	}

puts "======"
puts "Here's the shit that fuckedup"
fuckedup.each{|f|
	p f
}
puts "======"
end