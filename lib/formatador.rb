class Formatador

  STYLES = {
    :reset              => "\e[0m",
    :bold               => "\e[1m",
    :underline          => "\e[4m",
    :blink_slow         => "\e[5m",
    :blink_fast         => "\e[6m",
    :negative           => "\e[7m", # invert color/background_color
    :normal             => "\e[22m",
    :underline_none     => "\e[24m",
    :blink_off          => "\e[25m",
    :positive           => "\e[27m", # revert color/background_color
    :foreground_black   => "\e[30m",
    :foreground_red     => "\e[31m",
    :foreground_green   => "\e[32m",
    :foreground_yellow  => "\e[33m",
    :foreground_blue    => "\e[34m",
    :foreground_magenta => "\e[35m",
    :foreground_cyan    => "\e[36m",
    :foreground_white   => "\e[37m",
    :background_black   => "\e[40m",
    :background_red     => "\e[41m",
    :background_green   => "\e[42m",
    :background_yellow  => "\e[43m",
    :background_blue    => "\e[44m",
    :background_magenta => "\e[45m",
    :background_cyan    => "\e[46m",
    :background_white   => "\e[47m"
  }

  def display(string, styles = [])
    print(format(string, [*styles]))
  end

  def display_line(string, styles = [])
    display(string, styles)
    print("\n")
  end

  def format(string, styles, reset = true)
    if STDOUT.tty? && !styles.empty?
      formated = ''
      for style in styles
        formated << STYLES[style]
      end
      formated << string
      if reset
        formated << STYLES[:reset]
      end
      formated
    else
      string
    end
  end

end