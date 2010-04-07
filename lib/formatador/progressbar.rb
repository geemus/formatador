class Formatador

  def redisplay_progressbar(current, total, options = {})
    options = { :color => 'white', :width => 50 }.merge!(options)
    data = progressbar(current, total, options)
    if current < total
      redisplay(data)
    else
      redisplay("#{data}\n")
      @progressbar_started_at = nil
    end
  end

  private

  def progressbar(current, total, options)
    color = options[:color]
    started_at = options[:started_at]
    width = options[:width]

    output = []

    if options[:label]
      output << options[:label]
    end

    padding = ' ' * (total.to_s.size - current.to_s.size)
    output << "[#{color}]#{padding}#{current}/#{total}[/]"

    percent = current.to_f / total.to_f
    output << "[_white_]|[/][#{color}][_#{color}_]#{'*' * (percent * width).ceil}[/]#{' ' * (width - (percent * width).ceil)}[_white_]|[/]"

    if started_at
      elapsed = Time.now - started_at
      minutes = (elapsed / 60).round.to_s
      seconds = (elapsed % 60).round.to_s
      output << "#{minutes}:#{'0' if seconds.size < 2}#{seconds}"
    end

    output << ''
    output.join('  ')
  end

end
