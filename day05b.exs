# Advent of Code - Day 05 - "How About A Nice Game Of Chess?" (Part B)

defmodule Day05B do

    def is_valid("00000"<>_), do: true
    def is_valid(_), do: false

    def crack_password(salt), do: crack_password(salt, 0, {0, Map.new})
    def crack_password(_,_, {8, values}), do: Enum.join(Map.values(values))

    def crack_password(salt, counter, solution) do
      hash = :crypto.hash(:md5, salt <> Integer.to_string(counter)) |> Base.encode16()
      if is_valid(hash) do
        crack_password(salt, counter+1, update_solution(hash, solution))
      else
        crack_password(salt, counter+1, solution)
      end
    end

    defp is_valid_index(x) when x in ["0","1","2","3","4","5","6","7"], do: true
    defp is_valid_index(_), do: false

    defp update_solution(hash, {counter, values}) do
      IO.puts("#{hash} - #{inspect(values)}")
      chars = hash |> String.graphemes
      index = chars |> Enum.at(5)
      if !is_valid_index(index) || Map.has_key?(values, index) do
        IO.puts("Valid hash but index #{index} not useful")
        {counter, values}
      else
        digit = chars |> Enum.at(6)
        {counter+1, Map.put(values, index, digit)}
      end

    end

    def get_input(file_name) do
      File.read!(file_name)
    end

    def main(file_name) do
      get_input(file_name)
      |> crack_password
      |> IO.inspect
    end
end

# expected: 05ace8e3
#Day05B.main("day05.input.example")

Day05B.main("day05.input")
