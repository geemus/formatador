class Formatador

  def display_table(hashes, keys = nil, &block)
    headers = keys || []
    widths = {}
    if hashes.empty? && keys
      for key in keys
        widths[key] = key.to_s.length
      end
    else
      for hash in hashes
        for key in hash.keys
          unless keys
            headers << key
          end
          widths[key] = [key.to_s.length, widths[key] || 0, hash[key] && hash[key].to_s.length || 0].max
        end
        headers = headers.uniq
      end
    end

    if block_given?
      headers = headers.sort(&block)
    elsif !keys
      headers = headers.sort {|x,y| x.to_s <=> y.to_s}
    end

    split = "+"
    if headers.empty?
      split << '--+'
    else
      for header in headers
        split << ('-' * (widths[header] + 2)) << '+'
      end
    end

    display_line(split)
    columns = []
    for header in headers
      columns << "[bold]#{header}[/]#{' ' * (widths[header] - header.to_s.length)}"
    end
    display_line("| #{columns.join(' | ')} |")
    display_line(split)

    for hash in hashes
      columns = []
      for header in headers
        datum = hash[header] || ''
        columns << "#{datum}#{' ' * (widths[header] - datum.to_s.length)}"
      end
      display_line("| #{columns.join(' | ')} |")
      display_line(split)
    end
    nil
  end

end