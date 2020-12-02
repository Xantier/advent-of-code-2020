defmodule AdventOfCodeWeb.ApiControllerTwo do
  use AdventOfCodeWeb, :controller


  def two_one(conn, _params) do
    results = get_input()
    amount_of_correct_pws = results
      |> Enum.filter(fn {min, max, actual_letter, pw} ->
        l = String.to_charlist(pw)
            |> Enum.filter(fn it ->
          "#{it}" == "#{actual_letter}"
        end)
            |> Enum.count
        is_ok = l in min..max
        IO.puts(min)
        IO.puts(max)
        IO.puts(l)
        IO.puts(is_ok)
        IO.puts(l > min || l == min)
        IO.puts(l <= max)
        IO.puts("-------------")
        is_ok
      end)
      |> Enum.count
    text(conn, "Result: #{amount_of_correct_pws}")
  end

  def one_two(conn, _params) do
    numbs = get_input()
    text(conn, "result")
  end

  defp get_input() do
    Path.expand("lib/advent_of_code/inputs/two/input.csv")
      |> Path.absname
      |> File.read!
      |> String.split("\n")
      |> Enum.filter(fn it -> String.length(it) > 0 end)
      |> Enum.map(fn n ->
          [range, letter, pw] = String.split(n ," ");
          {range, letter, pw};
        end)
    |> Enum.map(fn it ->
      {range, letter, pw} = it
      {min, _} = Integer.parse(hd(String.split(range, "-")))
      {max, _} = Integer.parse(hd(tl(String.split(range, "-"))))
      actual_letter = hd(String.to_charlist(letter))
      {min, max, actual_letter, pw}
        end)

  end

end
