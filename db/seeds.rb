require 'csv'

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

current_season = 17

=begin
=end
##
#### Seed TeamYears
##
@csv = Rails.root.join('lib','data','team_years.csv')
@arr = CSV.open(@csv,"r").to_a

@arr.each_with_index{|row,i|
	next if i == 0
	@hsh = { :year => row[0], :team => row[1], :wins => row[2], :losses => row[3], :win_percentage => row[4], :offensive_rating => row[5], :defensive_rating => row[6], :season_outcome => row[7], :team_url => row[8], :team_home_url => row[9] }
	TeamYear.create( @hsh )
	p "TeamYear Created:"
	p @hsh	
	puts 
}




##
#### Seed Players
##

@players_csv = CSV.open( 
	Rails.root.join('lib','data','players_rough.csv'),
	"r").to_a

# Improve formatting & granularity from spreadsheet
@players = []
@players_csv.each{|old_player|
	@name_match = @players.select{ |player| player[0] == old_player[0] }
	if @name_match.count == 0
		@team_hist = old_player[-2..-1].to_s[2..-3].gsub("\", \""," => ")
		@add_player = old_player.insert(-1,@team_hist)
		@add_player.delete_at(-2)
		@players << @add_player
	elsif @name_match.count == 1
		@team_hist = old_player[-2..-1].to_s[2..-3].gsub("\", \""," => ")
		@name_match[0][-1] += ", #{@team_hist}"
	elsif @name_match.count > 1
		p "======"
		p @name_match
		p @name_match.class
		p @name_match.count
		p "======"
	else
		p "something weird happened"

	end	
}

# Update Team History, Current Team & Actve/Inactive Boolean
@payload = []
@players.each{|p|
	@new_hist = []
	p[-1].split(", ").each{|season|
		@split = season.split(" => ")
		@deliver_hist = [ @split[1], @split[0] ]
		@new_hist << @deliver_hist
	}

	@new_player = p
	@new_player.delete_at(-1)
	@new_player.insert(-1,@new_hist.sort_by{|first,second| -first[-2..-1].to_i })
	@new_player.delete_at(3)
	@new_player.insert(2,@new_hist.sort_by{|first,second| -first[-2..-1].to_i }[0][1])
	@new_player.insert(-1,true) if @new_hist.sort_by{|first,second| -first[-2..-1].to_i }[0][0][-2..-1].to_i == current_season
	@new_player.insert(-1,false) if @new_hist.sort_by{|first,second| -first[-2..-1].to_i }[0][0][-2..-1].to_i != current_season

	@payload << @new_player
}

@payload.each{|p|
	@player_hsh = { :name => p[0], :position_br => p[1], :year_of_birth => p[3], :current_team => p[2], :team_history => p[4], :active => p[5] } 
	Player.create(@player_hsh)
	p "Player Created:"
	p @player_hsh
	puts 
}


