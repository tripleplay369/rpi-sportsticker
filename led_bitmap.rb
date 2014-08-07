require_relative 'fonts'

class LEDBitmap
  def self.get_line_width(line)
    total = 0
    line.each_char do |c|
      total += Fonts.font[c].length / Fonts.lines_per_char
    end

    total
  end

  def self.get_line_bitmap(line, length, max_length)
    line_bitmap = ""
    line_length = 0
    for i in 0...Fonts.lines_per_char
      line.each_char do |c|
        char_bitmap = Fonts.font[c]
        line_bitmap += char_bitmap.split('+')[i] + " "
      end
      for j in 0 ... max_length - length
        line_bitmap += " "
      end
    end

    line_bitmap
  end

  def self.blank_line(length)
    line = ""
    for i in 0...length
      line += " "
    end

    line
  end

  def self.make_bitmap(line1, line2)
    fixed_max_len = 256

    bitmap = {height: 16, width: 0, data: ""}

    line1_len = get_line_width(line1)
    line2_len = get_line_width(line2)
    max_len = fixed_max_len

    line1_bitmap = get_line_bitmap(line1, line1_len, max_len)
    line2_bitmap = get_line_bitmap(line2, line2_len, max_len)

    bitmap[:width] = max_len
    bitmap[:data] = blank_line(max_len) + line1_bitmap + blank_line(max_len) + blank_line(max_len) + line2_bitmap + blank_line(max_len)
    bitmap[:data].gsub!(/ /, "0").gsub!(/8/, "1")

    bitmap
  end
end