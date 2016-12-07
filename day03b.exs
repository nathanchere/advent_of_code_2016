# Advent of Code - Day 03 - "Squares With Three Sides" (Part B)

defmodule Day03B do

  def is_valid_triangle([a,b,c]) when a + b > c, do: true
  def is_valid_triangle(_), do: false

  def map_result(true, {valid_count, invalid_count}), do: {valid_count + 1, invalid_count}
  def map_result(false, {valid_count, invalid_count}), do: {valid_count, invalid_count + 1}

  def to_column_format(items) do
    items
    |> Enum.chunk(3)
    |> Enum.map(fn(x)->rotate_matrix(x)end)
    |> List.flatten
    |> Enum.chunk(3)
  end

  defp rotate_matrix([[a1,b1,c1],[a2,b2,c2],[a3,b3,c3]]), do: [[a1,a2,a3],[b1,b2,b3],[c1,c2,c3]]

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
    |> to_column_format
    |> Enum.reduce({0,0}, fn(x,acc)-> Enum.sort(x) |> is_valid_triangle |> map_result(acc) end)

    IO.puts("Valid: #{valid}, Invalid: #{invalid}")
  end
end

# expected: 5 valid, 1 invalid
Day03B.main("day03.input.example")

Day03B.main("day03.input")
