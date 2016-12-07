# Advent of Code - Day 05 - "How About A Nice Game Of Chess?" (Part A)

defmodule Day05A do

    def is_valid("00000"<>_), do: true
    def is_valid(_), do: false

    def crack_password(salt), do: crack_password(salt, 0, [])
    def crack_password(_,_,solution) when length(solution)==8, do: Enum.join(solution)

    def crack_password(salt, counter, solution) do
      hash = :crypto.hash(:md5, salt <> Integer.to_string(counter)) |> Base.encode16()
      if is_valid(hash) do
        IO.puts("#{hash} - #{inspect(solution)}")
        digit = hash |> String.graphemes |> Enum.at(5)
        crack_password(salt, counter+1, solution ++ [digit])
      else
        crack_password(salt, counter+1, solution)
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

# expected: 18f47a30
Day05A.main("day05.input.example")

Day05A.main("day05.input")
