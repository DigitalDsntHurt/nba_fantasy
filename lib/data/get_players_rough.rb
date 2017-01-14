require 'nokogiri'
require 'rest-client'
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
#### Get Players - First Draft
##
@csv = CSV.open(
	"team_years.csv",
	"r"
).to_a

@players = []
@csv.each{ |row|
	next if row[0] == "year"
#	puts "======"
#	p row[1] + row[0]

	@u = row[-2]
	@x = "//table[@id='roster']/tbody/tr/td"
	@results = get_stuff_from_page(@u,@x)
	until @results.length < 1
		@r = @results.shift(8)
		@players << [ @r[0], @r[1], @r[4][-4..-1].to_i, row[1], row[0] ]
	end
}

CSV.open( 
	"players_rough.csv",
	"w+") do |newcsv|
	@players.each{|p|
		newcsv << p
	}
end