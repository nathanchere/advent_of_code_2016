# Advent of Code - Day 01 - "No Time for a Taxicab" (Part A)

defmodule Day01A do

  def calculate_position(instructions) do
    calculate_position(instructions, {0,0,:N})
  end

  defp calculate_position([head|instructions], position) do
    calculate_position(instructions, move(position, head))
  end

  defp calculate_position([], {x,y,_}), do: {x,y}

  defp parse_instruction("L"<>steps), do: {:L, String.to_integer(steps)}
  defp parse_instruction("R"<>steps), do: {:R, String.to_integer(steps)}

  defp move({x,y,:N}, {:L, steps}), do: {x-steps,y,:W}
  defp move({x,y,:S}, {:L, steps}), do: {x+steps,y,:E}
  defp move({x,y,:E}, {:L, steps}), do: {x,y+steps,:N}
  defp move({x,y,:W}, {:L, steps}), do: {x,y-steps,:S}
  defp move({x,y,:N}, {:R, steps}), do: {x+steps,y,:E}
  defp move({x,y,:S}, {:R, steps}), do: {x-steps,y,:W}
  defp move({x,y,:E}, {:R, steps}), do: {x,y-steps,:S}
  defp move({x,y,:W}, {:R, steps}), do: {x,y+steps,:N}

  defp calculate_distance({x,y}), do: abs(x) + abs(y)

  def get_input(file_name) do
    File.read!(file_name)
    |> String.strip
    |> String.split(", ")
  end

  def main(file_name) do
    get_input(file_name)
    |> Enum.map(fn(x)-> parse_instruction(x) end)
    |> calculate_position
    |> calculate_distance
    |> IO.puts
  end
end

# expected: 12
Day01A.main("day01.input.example")

Day01A.main("day01.input")
