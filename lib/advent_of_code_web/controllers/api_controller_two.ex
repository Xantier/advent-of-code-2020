defmodule AdventOfCodeWeb.ApiControllerTwo do
  use AdventOfCodeWeb, :controller


  def two_one(conn, _params) do
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

  def two_two(conn, _params) do
    inputs = get_input()
    amount_of_pws = inputs
      |> Enum.filter(fn {pos_1, pos_2, wanted_letter, pw} ->
           chars = String.to_charlist(pw)
           first_letter = Enum.at(chars, pos_1-1)
           second_letter = Enum.at(chars, pos_2-1)
           one_of_them = (first_letter == wanted_letter or second_letter == wanted_letter)
           both_of_them = (first_letter == wanted_letter and second_letter == wanted_letter)
           one_of_them and !both_of_them
         end)
      |> Enum.count
    text(conn, "result: #{amount_of_pws}")
  end

  defp get_input() do
    Path.expand("lib/advent_of_code/inputs/_02/input.csv")
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
