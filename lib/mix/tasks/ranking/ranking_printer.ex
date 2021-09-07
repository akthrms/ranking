defmodule Mix.Tasks.Ranking.RankingPrinter do
  use Mix.Task

  def run(filename) do
    Ranking.RankingPrinter.print(filename)
  end
end
