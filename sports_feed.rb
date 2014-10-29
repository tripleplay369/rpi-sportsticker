# encoding: utf-8
require 'net/http'
require 'json'
require 'cgi'

class SportsFeed
  def self.replace_international_chars(str)
    str.tr("ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſßŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
           "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSsssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
  end

  def self.get_scores
    my_leagues = ['soccer10', 'soccer23', 'mlb', 'nfl', 'nba', 'nhl']
    league_translation = {'mlb' => 'mlb',
                          'nfl' => 'nfl',
                          'nba' => 'nba',
                          'nhl' => 'nhl',
                          'soccer10' => 'bundesliga',
                          'soccer23' => 'epl'}
    scores_out = {leagues:{}}
    num = 0

    url = "http://espn.go.com/aggregator/cached/tea/sbMaster"
    response = Net::HTTP.get_response(URI.parse(url)).body
    scores_str = response.scan(/var sbMaster = (.*);/)[0][0]
    scores = JSON.parse(scores_str)
    # puts JSON.pretty_generate(scores)
    scores["sports"].each do |sport_scores|
      if sport_scores["leagues"]
        sport_scores["leagues"].each do |league|
          if my_leagues.include? league["league"]
            league_scores = []
            league["games"].each do |game|
              away_name = game["away"]["nickname"] ? game["away"]["nickname"] : game["away"]["name"]
              home_name = game["home"]["nickname"] ? game["home"]["nickname"] : game["home"]["name"]
              away_name = CGI.unescape_html(away_name)
              home_name = CGI.unescape_html(home_name)
              away_name = replace_international_chars away_name
              home_name = replace_international_chars home_name
              away = " " + away_name + " " + (game["status"] == 1 ? "at" : "")
              away_score = (game["status"] == 1 ? "" : game["away"]["score"].to_i.to_s)
              status = ((game["clock"] != nil && game["clock"] != "") ? (game["clock"] + " ") : "") + game["statusText"] + " "
              home = " " + home_name + " "
              home_score = (game["status"] == 1 ? "" : game["home"]["score"].to_i.to_s)

              league_scores << {away: away.downcase, away_score: away_score.downcase, status: status.downcase, home: home.downcase, home_score: home_score.downcase}
              num += 1
            end
            scores_out[:leagues][league_translation[league["league"]] + " "] = league_scores
          end
        end
      end
    end

    scores_out[:num] = num

    scores_out
  end
end
