# Advent of Code - Day 02 - "Bathroom Security" (Part B)

defmodule Day02B do

  def parse_instruction(items, first_digit) do
    items
    |> String.strip
    |> String.graphemes
    |> parse_instructions(first_digit)
   end

  defp parse_instructions([], digit), do: digit

  defp parse_instructions([head|tail], digit) do
    new_digit = move(head, digit)
    parse_instructions(tail, new_digit)
  end

  defp move("U", 3), do: 1
  defp move("U", digit) when digit in [6,7,8], do: digit - 4
  defp move("U", "A"), do: 6
  defp move("U", "B"), do: 7
  defp move("U", "C"), do: 8
  defp move("U", "D"), do: "B"
  defp move("U", digit), do: digit

  defp move("D", "B"), do: "D"
  defp move("D", 6), do: "A"
  defp move("D", 7), do: "B"
  defp move("D", 8), do: "C"
  defp move("D", digit) when digit in [2,3,4], do: digit + 4
  defp move("D", 1), do: 3
  defp move("D", digit), do: digit

  defp move("L", digit) when digit in [3,4,6,7,8,9], do: digit - 1
  defp move("L", "B"), do: "A"
  defp move("L", "C"), do: "B"
  defp move("L", digit), do: digit

  defp move("R", digit) when digit in [2,3,5,6,7,8], do: digit + 1
  defp move("R", "A"), do: "B"
  defp move("R", "B"), do: "C"
  defp move("R", digit), do: digit

  def get_input(file_name) do
    File.read!(file_name)
    |> String.strip
    |> String.split("\n")
  end

  def main(file_name) do
    [5|answer] =get_input(file_name)
    |> Enum.reduce([5], fn(x, acc) -> [parse_instruction(x, hd(acc))] ++ acc end)
    |> Enum.reverse

    answer |> Enum.join("-") |> IO.puts
  end
end

# expected: 5DB3
Day02B.main("day02.input.example")

Day02B.main("day02.input")
