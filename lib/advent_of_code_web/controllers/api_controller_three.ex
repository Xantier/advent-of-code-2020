defmodule AdventOfCodeWeb.ApiControllerThree do
  use AdventOfCodeWeb, :controller


  def three_one(conn, _params) do
    inputs = get_input()
    amount_of_correct_pws = inputs
      |> Enum.filter(fn {min, max, actual_letter, pw} ->
          l = String.to_charlist(pw)
              |> Enum.filter(fn it ->
            "#{it}" == "#{actual_letter}"
          end)
              |> Enum.count
          l in min..max
        end)
      |> Enum.count
    text(conn, "Result: #{amount_of_correct_pws}")
  end

  defp get_input() do
    Path.expand("lib/advent_of_code/inputs/_03/input.txt")
      |> Path.absname
      |> File.read!
      |> String.split("\n")
  end

end
