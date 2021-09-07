defmodule Mix.Tasks.Ranking.ScorePrinter do
  use Mix.Task

  def run(filename) do
    Ranking.ScorePrinter.print(filename)
  end
end
