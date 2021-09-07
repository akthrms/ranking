defmodule Mix.Tasks.Ranking.Printer do
  use Mix.Task

  def run(filename \\ "test.csv") do
    Ranking.Printer.print(filename)
  end
end
