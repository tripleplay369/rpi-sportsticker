require_relative 'led_bitmap'
require_relative 'sports_feed'
require 'timers'
require 'thread'

class Sign
  @first_refresh = true
  @scores = {}
  @current_index = 0
  @lock = Mutex.new

  def self.get_bitmap_for_score(league_str, score_str)
    # string is like:
    # "Pittsburgh 0   San Francisco 0 (TOP 1ST)"
    score_str = String.new score_str

    score_str.downcase!.gsub!(/\^/, "*")
    score_str.gsub!(/ - /, "-")

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

  def self.write_to_sign(bitmap)
    bitmap[:data].gsub!(/0/, " ").gsub!(/1/, "8")
    puts bitmap[:data].scan(/.{#{bitmap[:width]}}|.+/).join("\n")
  end

  def self.run
    scores_refresh_time = 30
    display_refresh_time = 5

    timers = Timers::Group.new

    timers.every(scores_refresh_time) do
      @lock.synchronize do
        @scores = SportsFeed.get_scores

        if @first_refresh
          timers.every(display_refresh_time) do
            @lock.synchronize do
              if @scores[:num] > 0
                @current_index %= @scores[:num]
                i = 0
                puts @scores.inspect
                @scores[:leagues].each do |league_name, league_scores|
                  league_scores.each do |score|
                    if i == @current_index
                      write_to_sign(get_bitmap_for_score(league_name, score))
                    end
                    i += 1
                  end
                end
              end
              @current_index += 1
            end
          end
        end
        @first_refresh = false
      end
    end

    loop { timers.wait }
  end
end

Sign.run