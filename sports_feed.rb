require 'net/http'
require 'json'
require 'cgi'

class SportsFeed
  def self.get_scores
    my_leagues = ['nfl', 'mlb', 'nba', 'nhl']
    scores_out = {leagues:{}}
    num = 0

    url = "http://espn.go.com"
    response = Net::HTTP.get_response(URI.parse(url)).body
    scores_str = response.scan(/var sbMaster = (.*)\n/)[0][0]
    scores = JSON.parse(scores_str)
    # puts JSON.pretty_generate(scores)
    scores["sports"].each do |sport_scores|
      if sport_scores["leagues"]
        sport_scores["leagues"].each do |league|
          if my_leagues.include? league["league"]
            league_scores = []
            league["games"].each do |game|
              away = " " + game["away"]["nickname"] + " " + (game["status"] == 1 ? "at" : "")
              away_score = (game["status"] == 1 ? "" : game["away"]["score"].to_i.to_s)
              status = ((game["clock"] != nil && game["clock"] != "") ? (game["clock"] + " ") : "") + game["statusText"] + " "
              if status == "F "
                status = "FINAL "
              end
              home = " " + game["home"]["nickname"] + " "
              home_score = (game["status"] == 1 ? "" : game["home"]["score"].to_i.to_s)

              league_scores << {away: away.downcase, away_score: away_score.downcase, status: status.downcase, home: home.downcase, home_score: home_score.downcase}
              num += 1
            end
            scores_out[:leagues][league["league"] + " "] = league_scores
          end
        end
      end
    end

    scores_out[:num] = num

    scores_out
  end
end
