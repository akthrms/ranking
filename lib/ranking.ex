defmodule Ranking do
  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Stream.drop(1)
    |> Enum.reduce(%{}, &sum_score/2)
    |> Enum.reduce([], &average_score/2)
    |> Enum.sort_by(&Map.fetch(&1, :average), :desc)
    |> print_ranking()
  end

  defp sum_score([_, id, score], score_map) do
    score = String.to_integer(score)

    score_map
    |> Map.update(
      id,
      %{score: score, count: 1},
      fn %{score: old_score, count: old_count} ->
        %{score: old_score + score, count: old_count + 1}
      end
    )
  end

  defp average_score({id, %{score: score, count: count}}, score_list) do
    average = div(score, count)

    [%{id: id, average: average} | score_list]
  end

  defp print_ranking(scores) do
    IO.puts("rank,player_id,mean_score")
    print_score(scores, nil, 1, 1)
  end

  defp print_score([], _, _, _) do
  end

  defp print_score([%{average: average} | _], prev, rank, _) when average < prev and rank >= 10 do
  end

  defp print_score([%{id: id, average: average} | scores], nil, rank, count) do
    IO.puts(Integer.to_string(rank) <> "," <> id <> "," <> Integer.to_string(average))
    print_score(scores, average, rank, count + 1)
  end

  defp print_score([%{id: id, average: average} | scores], prev, _, count) when average < prev do
    IO.puts(Integer.to_string(count) <> "," <> id <> "," <> Integer.to_string(average))
    print_score(scores, average, count, count + 1)
  end

  defp print_score([%{id: id, average: average} | scores], _, rank, count) do
    IO.puts(Integer.to_string(rank) <> "," <> id <> "," <> Integer.to_string(average))
    print_score(scores, average, rank, count + 1)
  end
end
