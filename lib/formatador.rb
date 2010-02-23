class Formatador

  STYLES = {
    :"\/"             => "0",
    :reset            => "0",
    :bold             => "1",
    :underline        => "4",
    :blink_slow       => "5",
    :blink_fast       => "6",
    :negative         => "7", # invert color/color
    :normal           => "22",
    :underline_none   => "24",
    :blink_off        => "25",
    :positive         => "27", # revert color/color
    :black            => "30",
    :red              => "31",
    :green            => "32",
    :yellow           => "33",
    :blue             => "34",
    :magenta          => "35",
    :purple           => "35",
    :cyan             => "36",
    :white            => "37",
    :_black_          => "40",
    :_red_            => "41",
    :_green_          => "42",
    :_yellow_         => "43",
    :_blue_           => "44",
    :_magenta_        => "45",
    :_purple_         => "45",
    :_cyan_           => "46",
    :_white_          => "47",
    :light_black      => "90",
    :light_red        => "91",
    :light_green      => "92",
    :light_yellow     => "93",
    :light_blue       => "94",
    :light_magenta    => "95",
    :light_purple     => "95",
    :light_cyan       => "96",
    :_light_black_    => "100",
    :_light_red_      => "101",
    :_light_green_    => "102",
    :_light_yellow_   => "103",
    :_light_blue_     => "104",
    :_light_magenta_  => "105",
    :_light_purple_   => "105",
    :_light_cyan_     => "106",
  }

  FORMAT_REGEX = /\[(#{ STYLES.keys.join('|') })\]/ix
  INDENT_REGEX = /\[indent\]/ix

  def initialize
    @indent = 1
  end

  def display(string = '')
    print(format("[indent]#{string}"))
    STDOUT.flush
  end

  def display_line(string = '')
    display(string)
    print("\n")
  end

  def display_table(hashes, keys = nil)
    headers = keys || []
    widths = {}
    for hash in hashes
      for key, value in hash.keys
        unless keys
          headers << key
        end
        widths[key] = [key.to_s.length, widths[key] || 0, hash[key] && hash[key].length || 0].max
      end
      headers = headers.uniq
    end

    split = "+"
    for header in headers
      split << ('-' * (widths[header] + 2)) << '+'
    end

    display_line(split)
    display_line("| #{headers.join(' | ')} |")
    display_line(split)

    for hash in hashes
      columns = []
      for header in headers
        datum = hash[header] || ''
        columns << "#{datum}#{' ' * (widths[header] - datum.length)}"
      end
      display_line("| #{columns.join(' | ')} |")
      display_line(split)
    end
  end

  def format(string)
    if STDOUT.tty?
      string.gsub(FORMAT_REGEX) { "\e[#{STYLES[$1.to_sym]}m" }.gsub(INDENT_REGEX) { indentation }
    else
      string.gsub(INDENT_REGEX) { indentation }
    end
  end

  def indent(&block)
    @indent += 1
    yield
    @indent -= 1
  end

  def indentation
    '  ' * @indent
  end

  def redisplay(string = '')
    print("\r")
    display("#{string}")
  end

  %w{display display_line display_table format redisplay}.each do |method|
    eval <<-DEF
      def self.#{method}(*args)
        new.#{method}(*args)
      end
    DEF
  end

end
