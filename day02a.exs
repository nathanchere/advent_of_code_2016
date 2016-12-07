# Advent of Code - Day 02 - "Bathroom Security" (Part A)

defmodule Day02A do

  def parse_instruction(items) do
    items
    |> String.strip
    |> String.graphemes
    |> parse_instructions(5)
   end

  defp parse_instructions([], digit), do: digit

  defp parse_instructions([head|tail], digit) do
    new_digit = move(head, digit)
    parse_instructions(tail, new_digit)
  end

  defp move("U", digit) when digit < 3, do: digit
  defp move("U", digit), do: digit - 3
  defp move("L", digit) when digit in [1,4,7] , do: digit
  defp move("L", digit), do: digit - 1
  defp move("R", digit) when digit in [3,6,9] , do: digit
  defp move("R", digit), do: digit + 1
  defp move("D", digit) when digit > 6, do: digit
  defp move("D", digit), do: digit + 3

  def get_input do
    File.read!("day02.input")
    |> String.strip
    |> String.split("\n")
  end

  def main() do
    get_input
    |> Enum.map(fn(x)-> parse_instruction(x) end)
    |> Enum.join("-")
    |> IO.puts
  end
end

Day02A.main()
