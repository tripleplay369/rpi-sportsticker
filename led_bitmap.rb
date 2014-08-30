require_relative 'fonts'

class LEDBitmap
  def self.get_line_width(line)
    total = 0
    line.each_char do |c|
      total += Fonts.font[c].length / Fonts.lines_per_char
    end

    total
  end

  def self.get_line_bitmap(components, lengths, full_lengths, width)
    line_bitmap = ""
    for i in 0...Fonts.lines_per_char
      for k in 0...components.length
        components[k].each_char do |c|
          char_bitmap = Fonts.font[c]
          line_bitmap += char_bitmap.split('+')[i] + " "
        end
        for j in 0...full_lengths[k] - lengths[k]
          line_bitmap += " "
        end

        if k == 0
          line_bitmap += "8 "
        end
      end
      for k in 0...width - full_lengths.inject(:+) - 2
        line_bitmap += " "
      end
    end

    line_bitmap
  end

  def self.blank_line(length, line_pos)
    line = ""
    for i in 0...length
      if line_pos == i
        line += "8"
      else
        line += " "
      end
    end

    line
  end

  def self.make_bitmap(league, score)
    width = 256
    bitmap = {height: 16, width: 0, data: ""}

    league_len = get_line_width league
    status_len = get_line_width score[:status]
    away_len = get_line_width score[:away]
    home_len = get_line_width score[:home]
    away_score_len = get_line_width score[:away_score]
    home_score_len = get_line_width score[:home_score]

    len1 = [league_len, status_len].max
    len2 = [away_len, home_len].max
    len3 = [away_score_len, home_score_len].max

    line1_bitmap = get_line_bitmap([league, score[:away], score[:away_score]], [league_len, away_len, away_score_len], [len1, len2, len3], width)
    line2_bitmap = get_line_bitmap([score[:status], score[:home], score[:home_score]], [status_len, home_len, home_score_len], [len1, len2, len3], width)

    bitmap[:width] = width
    bitmap[:data] = blank_line(width, len1 - 1) + line1_bitmap + blank_line(width, len1) + blank_line(width, len1) + line2_bitmap + blank_line(width, len1 - 1)
    bitmap[:data].gsub!(/ /, "0").gsub!(/8/, "1")

    bitmap
  end
end