class LEDBitmap
  @@font = {'a' => ' 88+' +
                   '8 8+' +
                   '8 8+' +
                   '888+' +
                   '8 8+' +
                   '   +',
            'b' => '88 +' +
                   '8 8+' +
                   '88 +' +
                   '8 8+' +
                   '888+' +
                 '   +',
            'c' => ' 88+' +
                   '8  +' +
                   '8  +' +
                   '8  +' +
                   '888+' +
                   '   +',
            'd' => '888+' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '88 +' +
                   '   +',
            'e' => ' 88+' +
                   '8  +' +
                   '888+' +
                   '8  +' +
                   '888+' +
                   '   +',
            'f' => ' 88+' +
                   '8  +' +
                   '888+' +
                   '8  +' +
                   '8  +' +
                   '   +',
            'g' => ' 88+' +
                   '8  +' +
                   '8 8+' +
                   '8 8+' +
                   '88 +' +
                   '   +',
            'h' => '8 8+' +
                   '8 8+' +
                   '888+' +
                   '8 8+' +
                   '8 8+' +
                   '   +',
            'i' => '8+' +
                   '8+' +
                   '8+' +
                   '8+' +
                   '8+' +
                   ' +',
            'j' => ' 88+' +
                   '  8+' +
                   '  8+' +
                   '8 8+' +
                   ' 88+' +
                   '   +',
            'k' => '8 8+' +
                   '8 8+' +
                   '88 +' +
                   '8 8+' +
                   '8 8+' +
                   '   +',
            'l' => '8 +' +
                   '8 +' +
                   '8 +' +
                   '8 +' +
                   '88+' +
                   '  +',
            'm' => '88 8 +' +
                   '8 8 8+' +
                   '8 8 8+' +
                   '8 8 8+' +
                   '8   8+' +
                   '     +',
            'n' => '88 +' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '   +',
            'o' => ' 88+' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '888+' +
                   '   +',
            'p' => ' 88+' +
                   '8 8+' +
                   '8 8+' +
                   '888+' +
                   '8  +' +
                   '   +',
            'q' => ' 88+' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '88 +' +
                   '  8+',
            'r' => '88 +' +
                   '8 8+' +
                   '8 8+' +
                   '88 +' +
                   '8 8+' +
                   '   +',
            's' => ' 88+' +
                   '8  +' +
                   ' 8 +' +
                   '  8+' +
                   '888+' +
                   '   +',
            't' => '888+' +
                   ' 8 +' +
                   ' 8 +' +
                   ' 8 +' +
                   ' 8 +' +
                   '   +',
            'u' => '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '888+' +
                   '   +',
            'v' => '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '88 +' +
                   '   +',
            'w' => '8   8+' +
                   '8 8 8+' +
                   '8 8 8+' +
                   '8 8 8+' +
                   '8888 +' +
                   '     +',
            'x' => '8 8+' +
                   '888+' +
                   ' 8 +' +
                   '8 8+' +
                   '8 8+' +
                   '   +',
            'y' => '8 8+' +
                   '8 8+' +
                   '88 +' +
                   ' 8 +' +
                   ' 8 +' +
                   '   +',
            'z' => '888+' +
                   '  8+' +
                   ' 8 +' +
                   '8  +' +
                   '888+' +
                   '   +',
            '0' => ' 88+' +
                   '8 8+' +
                   '8 8+' +
                   '8 8+' +
                   '888+' +
                   '   +',
            '1' => ' 8+' +
                   '88+' +
                   ' 8+' +
                   ' 8+' +
                   ' 8+' +
                   '  +',
            '2' => '88 +' +
                   '  8+' +
                   ' 8 +' +
                   '8  +' +
                   '888+' +
                   '   +',
            '3' => '888+' +
                   '  8+' +
                   '888+' +
                   '  8+' +
                   '88 +' +
                   '   +',
            '4' => '8  +' +
                   '8 8+' +
                   '8 8+' +
                   '888+' +
                   '  8+' +
                   '   +',
            '5' => '888+' +
                   '8  +' +
                   '88 +' +
                   '  8+' +
                   '888+' +
                   '   +',
            '6' => '  8+' +
                   ' 8 +' +
                   '888+' +
                   '8 8+' +
                   '888+' +
                   '   +',
            '7' => '888+' +
                   '  8+' +
                   ' 8 +' +
                   ' 8 +' +
                   ' 8 +' +
                   '   +',
            '8' => '888+' +
                   '8 8+' +
                   ' 8 +' +
                   '8 8+' +
                   '888+' +
                   '   +',
            '9' => '88 +' +
                   '8 8+' +
                   '888+' +
                   '  8+' +
                   '88 +' +
                   '   +',
            ':' => ' +' +
                   ' +' +
                   '8+' +
                   ' +' +
                   '8+' +
                   ' +',
            '(' => ' 8+' +
                   '8 +' +
                   '8 +' +
                   '8 +' +
                   ' 8+' +
                   '  +',
            ')' => '8 +' +
                   ' 8+' +
                   ' 8+' +
                   ' 8+' +
                   '8 +' +
                   '  +',
            '*' => ' 8 +' +
                   '8 8+' +
                   ' 8 +' +
                   '   +' +
                   '   +' +
                   '   +',
            ' ' => '  +' +
                   '  +' +
                   '  +' +
                   '  +' +
                   '  +' +
                   '  +',
            '.' => ' +' +
                   ' +' +
                   ' +' +
                   ' +' +
                   '8+' +
                   ' +',
            '-' => '  +' +
                   '  +' +
                   '88+' +
                   '  +' +
                   '  +' +
                   '  +',
  }

  def self.get_line_width(line)
    lines_per_char = 6
    total = 0
    line.each_char do |c|
      total += @@font[c].length / lines_per_char
    end

    total
  end

  def self.get_line_bitmap(line, length, max_length)
    line_bitmap = ""
    line_length = 0
    for i in 0...6
      line.each_char do |c|
        char_bitmap = @@font[c]
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
    bitmap = {height: 16, width: 0, data: ""}

    line1_len = get_line_width(line1)
    line2_len = get_line_width(line2)
    max_len = [line1_len, line2_len].max

    line1_bitmap = get_line_bitmap(line1, line1_len, max_len)
    line2_bitmap = get_line_bitmap(line2, line2_len, max_len)

    bitmap[:width] = max_len
    bitmap[:data] = blank_line(max_len) + line1_bitmap + blank_line(max_len) + line2_bitmap + blank_line(max_len) + blank_line(max_len)
    bitmap[:data].gsub!(/ /, "0").gsub!(/8/, "1")

    bitmap
  end
end