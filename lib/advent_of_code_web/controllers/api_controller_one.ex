defmodule AdventOfCodeWeb.ApiControllerOne do
  use AdventOfCodeWeb, :controller


  def one_one(conn, _params) do
    numbs = get_numbers()
    {first, second} = find_complement(hd(numbs), Enum.sort(tl(numbs)))

    text(conn, "First number: #{first}, second number: #{second}\nResult: #{first * second}")
  end

  def one_two(conn, _params) do
    numbs = get_numbers()
    {first, second, third} = find_triply(hd(numbs), hd(tl(numbs)), Enum.sort(tl(numbs)))
    text(conn, "First number: #{first}, second number: #{second}, third number #{third}\nResult: #{first * second * third}")
  end

  defp get_numbers() do
    number_filter = fn it ->
      case it do
        {v, _} -> v < 2020
        _        -> false
      end
    end

    Path.expand("lib/advent_of_code/inputs/_01/numbers.csv")
      |> Path.absname
      |> File.read!
      |> String.split("\n")
      |> Enum.map(fn n -> Integer.parse(n); end)
      |> Enum.filter(number_filter)
      |> Enum.map(fn {it, _} -> it; end)
  end

  defp find_complement(head, tail) do
    candidates = Enum.filter(tail, fn it -> head + it === 2020 end)
    case candidates do
      [] -> find_complement(hd(tail), Enum.sort(tl(tail)))
      [winner] -> {head, winner}
    end
  end

  defp find_triply(head, second_head, tail) do
    candidates = Enum.filter(tail, fn it -> head + second_head + it === 2020 end)
    case candidates do
      [] -> find_triply(second_head, hd(tail), Enum.sort(tl(tail)))
      [winner] -> {head, second_head, winner}
    end
  end
end
