start = Time.now

require 'rest-client'
require 'nokogiri'
require 'date'
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

##
#### Setup Time
##
year = Date.today.prev_day.year
month = Date.today.prev_day.month
date = Date.today.prev_day.day


##
#### Basketball Reference Scrape Setup
##
base = "http://www.basketball-reference.com"
teams_url = "/teams/"
yesterdays_games = "http://www.basketball-reference.com/boxscores/index.cgi?month=#{month}&day=#{date}&year=#{year}"


##
#### Seed TeamYears since a Year
##
team_years_start_date = 2009

# Get first draft of team rows
teams = []
xpath = "//div[@id='all_teams_active']//table/tbody/tr/th/a | //div[@id='all_teams_active']//table/tbody/tr/th/a/@href"
team_results = get_stuff_from_page(base+teams_url,xpath)
until team_results.length < 1
	@new = team_results.shift(2)
	if @new[0].include?("Portland")
		teams << [ "Portland", "Trail Blazers", @new[1][-4..-2], @new[1][-4..-2], base+@new[1] ]
	elsif @new[1].include?("NJN") or @new[1].include?("CHA") or @new[1].include?("NOH")
		@name = @new[0].split(" ")
		@team_name = @name.pop
		@city = @name.join(" ")
		teams << [ @city, @team_name, @new[1][-4..-2], @new[1][-4..-2].gsub("NJN","BRK").gsub("CHA","CHO").gsub("NOH","NOP"), base+@new[1] ]
	else
		@name = @new[0].split(" ")
		@team_name = @name.pop
		@city = @name.join(" ")
		teams << [ @city, @team_name, @new[1][-4..-2], @new[1][-4..-2], base+@new[1] ]
	end
end
=begin
teams.each{|t|
	p "======"
	p t
}
p "======"
p teams.class
p teams.count
=end


# Create TeamYear rows
team_years = [["year","team","wins","losses","win_percentage","offensive_rating","defensive_rating","season_outcome","team_year_url","team_home_url"]]
(teams.length).times{|t|
	@team_url = teams[t][-1]
	@xpath = "//table[@id='#{teams[t][2]}']/tbody/tr/* | //table[@id='#{teams[t][2]}']/tbody/tr/td[2]/a/@href"
	@results = get_stuff_from_page(@team_url,@xpath)
	(year - team_years_start_date).times do
		@row = @results.shift(18)
		@row.delete_at(1)
		team_years << [ @row[0], @row[1].gsub("*",""), @row[3], @row[4], @row[5], @row[10], @row[12], @row[-3], base+@row[2], @team_url ]#.flatten
	end
}

CSV.open("team_years.csv","w+") do |f|
	team_years.each{|t|
		f << t
		puts "======"
		p t
	}
end

puts "Script took #{((Time.now-start)/60).round(2)} minutes to run"


