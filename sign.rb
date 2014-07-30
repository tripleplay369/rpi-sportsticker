require_relative 'led_bitmap'
require_relative 'sports_feed'

class Sign
  def self.get_bitmap_for_score(league_str, score_str)
    # string is like:
    # "Pittsburgh 0   San Francisco 0 (TOP 1ST)"
    score_str.downcase!.gsub!(/\^/, "*")

    components = score_str.scan(/^(.*)   (.*) (\(.*\))$/)[0]

    if components.nil? # game hasn't started yet
      components = score_str.scan(/^(.* at) (.*) (\(.*\))$/)[0]
    end

    score1 = components[0]
    score2 = components[1]
    status = components[2]

    line1 = score1
    line2 = score2

    if score1.length > score2.length
      line2 += " " + status
      line1 += " (" + league_str.downcase + ")"
    else
      line1 += " " + status
      line2 += " (" + league_str.downcase + ")"
    end

    LEDBitmap.make_bitmap(line1, line2)
  end

  def self.run
    scores = SportsFeed.get_scores
    scores.each do |league, league_scores|
      league_scores.each do |score|
        bitmap = get_bitmap_for_score(league, score) unless score.nil?
      end
    end
  end
end

Sign.run