defmodule Mix.Tasks.Ranking.TestDataGenerator do
  use Mix.Task

  def run(filename) do
    Ranking.TestDataGenerator.generate(filename)
  end
end
