require 'net/http'
require 'json'
require 'cgi'

class SportsFeed
  def self.get_local_headlines
    feeds = {'Cubs' => 'mlb:16',
             'Bulls' => 'nba:4',
             'Blackhawks' => 'nhl:4',
             'Bears' => 'nfl:3',
            }

    api_key = 'fd3998mu4gmyx2jffg66vkjq'

    headlines = {}

    feeds.each do |team_name, feed|
      league = feed.split(':')[0]
      team_id = feed.split(':')[1]
      url = "http://api.espn.com/v1/now?leagues=#{league}&teams=#{team_id}&content=story&apikey=fd3998mu4gmyx2jffg66vkjq"

      response = {}
      while response['feed'].nil?
        response = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
      end

      team_headlines = []
      response['feed'].each do |story|
        if story['type'] == 'HeadlineNews'
          team_headlines << story['description']
        end
      end

      headlines[team_name] = team_headlines
    end

    headlines
  end

  def self.get_top_headlines
    api_key = 'fd3998mu4gmyx2jffg66vkjq'
    headlines = []
    url = "http://api.espn.com/v1/now/top?content=story&apikey=fd3998mu4gmyx2jffg66vkjq"

    response = {}
    while response['feed'].nil?
      response = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
    end

    response['feed'].each do |story|
      if story['type'] == 'HeadlineNews'
        headlines << story['description']
      end
    end

    headlines
  end

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
        if !(key =~ /#{feed}_s_left\d/).nil? && !value[0].include?(' ET)') # means schedule, not score
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
