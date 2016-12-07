# Advent of Code - Day 04 - "Security Through Obscurity" (Part A)

defmodule Day04A do

    defp is_valid_room(info) do
      checksum = info[:values]
      |> String.graphemes
      |> Enum.group_by(fn(x)->x end)
      |> Enum.map(fn({a,b})->{a, length(b)} end)
      |> Enum.sort_by(fn({a,_})->a end)
      |> Enum.sort_by(fn({_,b})->-b end)
      |> Enum.take(5)
      |> Enum.map(fn({a,_})->a end)
      |> Enum.join

      info[:checksum] == checksum
    end

    defp to_room_info(text) do
      [_,values,id,checksum] = Regex.run(~r/^((?:[a-z]+))(\d+)\[([a-z]{5})\]/, text)
      %{values: values, id: String.to_integer(id), checksum: checksum}
    end

    def get_input(file_name) do
      File.read!(file_name)
      |> String.replace("-","")
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
    end

    def main(file_name) do
      get_input(file_name)
      |> Enum.map(&to_room_info/1)
      |> Enum.filter(&is_valid_room/1)
      |> Enum.reduce(0, fn(x,acc)->acc+x[:id] end)
      |> IO.inspect
    end
end

# expected: 1514
Day04A.main("day04.input.example")

Day04A.main("day04.input")
