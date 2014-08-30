require_relative 'led_bitmap'
require_relative 'sports_feed'
require 'timers'
require 'thread'

class Sign
  @scores = nil
  @current_index = 0
  @lock = Mutex.new

  def self.write_to_sign(bitmap)
    # bitmap[:data].gsub!(/0/, " ").gsub!(/1/, "8")
    # puts bitmap[:data].scan(/.{#{bitmap[:width]}}|.+/).join("\n")

    `perl write.pl #{bitmap[:height]} #{bitmap[:width]} #{bitmap[:data]}`
  end

  def self.refresh_scores
    begin
      scores = SportsFeed.get_scores
    rescue
    end

    @lock.synchronize do
      unless scores.nil?
        @scores = scores
      end
    end
  end

  def self.update_sign
    @lock.synchronize do
      if !@scores.nil? && @scores[:num] > 0
        @current_index %= @scores[:num]
        i = 0
        @scores[:leagues].each do |league_name, league_scores|
          league_scores.each do |score|
            if i == @current_index
              write_to_sign(LEDBitmap.make_bitmap(score[0], score[1]))
            end
            i += 1
          end
        end
      end
      @current_index += 1
    end
  end

  def self.run
    scores_refresh_time = 120
    display_refresh_time = 14

    timers = Timers::Group.new

    refresh_scores
    timers.every(scores_refresh_time) do
      refresh_scores
    end

    update_sign
    timers.every(display_refresh_time) do
      update_sign
    end

    loop { timers.wait }
  end
end

Sign.run