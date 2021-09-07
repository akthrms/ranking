defmodule Ranking.RankingPrinter do
  def print(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Stream.drop(1)
    |> Enum.reduce(%{}, &sum_score/2)
    |> Enum.reduce([], &mean_score/2)
    |> Enum.sort_by(&Map.fetch(&1, :mean), :desc)
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

  defp mean_score({id, %{score: score, count: count}}, score_list) do
    mean = div(score, count)

    [%{id: id, mean: mean} | score_list]
  end

  defp print_ranking(scores) do
    IO.puts("rank,player_id,mean_score")
    print_score(scores, nil, 1, 1)
  end

  defp print_score([], _, _, _) do
  end

  defp print_score([%{mean: mean} | _], prev, rank, count)
       when (mean < prev and count > 10) or rank > 10 do
  end

  defp print_score([%{id: id, mean: mean} | scores], nil, rank, count) do
    IO.puts(Integer.to_string(rank) <> "," <> id <> "," <> Integer.to_string(mean))
    print_score(scores, mean, rank, count + 1)
  end

  defp print_score([%{id: id, mean: mean} | scores], prev, _, count) when mean < prev do
    IO.puts(Integer.to_string(count) <> "," <> id <> "," <> Integer.to_string(mean))
    print_score(scores, mean, count, count + 1)
  end

  defp print_score([%{id: id, mean: mean} | scores], _, rank, count) do
    IO.puts(Integer.to_string(rank) <> "," <> id <> "," <> Integer.to_string(mean))
    print_score(scores, mean, rank, count + 1)
  end
end
