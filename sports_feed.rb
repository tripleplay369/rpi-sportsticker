require 'net/http'
require 'json'
require 'cgi'

class SportsFeed
  def self.get_scores
    feeds = {'NFL' => 'nfl',
             'NBA' => 'nba',
             'MLB' => 'mlb',
             'NHL' => 'nhl',
            }

    scores = {leagues:{}}
    num = 0
    feeds.each do |league_name, feed|
      url = "http://sports.espn.go.com/#{feed}/bottomline/scores"
      response = CGI::parse(Net::HTTP.get_response(URI.parse(url)).body)
      
      league_scores = []
      response.each do |key, value|
        if !(key =~ /#{feed}_s_left\d/).nil?
          league_scores << value[0]
          num += 1
        end
      end

      scores[:leagues][league_name] = league_scores
    end

    scores[:num] = num

    scores
  end
end
