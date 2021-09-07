defmodule Ranking.TestDataGenerator do
  def generate(filename) do
    data = [
      ["create_timestamp", "player_id", "score"]
      | generate_data()
    ]

    file = File.open!(filename, [:write, :utf8])

    data
    |> CSV.encode()
    |> Enum.each(&IO.write(file, &1))
  end

  defp generate_data do
    0..10_000_000
    |> Enum.map(fn _ ->
      player_id =
        :rand.uniform(10000)
        |> Integer.to_string()
        |> String.pad_leading(5, "0")

      score =
        :rand.uniform(10000)
        |> Integer.to_string()

      ["1998/01/01 11:59", "player" <> player_id, score]
    end)
  end
end
