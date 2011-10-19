Shindo.tests("Formatador") do

output = <<-OUTPUT
    +---+
    | [bold]a[/] |
    +---+
    | 1 |
    +---+
    | 2 |
    +---+
OUTPUT
output = Formatador.parse(output)

  tests("#display_table([{:a => 1}, {:a => 2}])").returns(output) do
    capture_stdout do
      Formatador.display_table([{:a => 1}, {:a => 2}])
    end
  end

output = <<-OUTPUT
    +--------+
    | [bold]header[/] |
    +--------+
    +--------+
OUTPUT
output = Formatador.parse(output)

  tests("#display_table([], [:header])").returns(output) do
    capture_stdout do
      Formatador.display_table([], [:header])
    end
  end

output = <<-OUTPUT
    +--------+
    | [bold]header[/] |
    +--------+
    |        |
    +--------+
OUTPUT
output = Formatador.parse(output)

  tests("#display_table([{:a => 1}], [:header])").returns(output) do
    capture_stdout do
      Formatador.display_table([{:a => 1}], [:header])
    end
  end

end
