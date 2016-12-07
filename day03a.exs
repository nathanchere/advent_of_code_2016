# Advent of Code - Day 03 - "Squares With Three Sides" (Part A)

defmodule Day03A do

  def is_valid_triangle([a,b,c]) when a + b > c, do: true
  def is_valid_triangle(_), do: false

  def map_result(true, {valid_count, invalid_count}), do: {valid_count + 1, invalid_count}
  def map_result(false, {valid_count, invalid_count}), do: {valid_count, invalid_count + 1}

  defp to_sides(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(fn(x)-> String.trim(x) |> String.to_integer end)
  end

  def get_input(file_name) do
    File.read!(file_name)
    |> String.strip
    |> String.split("\n")
    |> Enum.map(fn(x)-> to_sides(x) end)
  end

  def main(file_name) do
    {valid,invalid} = get_input(file_name)
    |> Enum.reduce({0,0}, fn(x,acc)-> Enum.sort(x) |> is_valid_triangle |> map_result(acc) end)

    IO.puts("Valid: #{valid}, Invalid: #{invalid}")
  end
end

# expected: 2 valid, 4 invalid
Day03A.main("day03.input.example")

Day03A.main("day03.input")
