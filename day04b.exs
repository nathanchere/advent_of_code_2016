# Advent of Code - Day 04 - "Security Through Obscurity" (Part B)

defmodule Day04B do

    def decrypt(info) do
      shift = rem(info[:id],26)
      decrypted = info[:values]
      |> to_charlist
      |> Enum.map(fn(x)->decrypt(x,shift) end)
      |> to_string
      %{id: info[:id], decrypted: decrypted}
    end

    def decrypt(?-, _), do: " "
    def decrypt(character, shift), do: rem((character - ?a + shift), 26) + ?a

    def is_where_north_pole_objects_are_stored(input), do: input[:decrypted] |> String.contains?("north")

    defp is_valid_room(info) do
      checksum = info[:values]
      |> String.replace("-","")
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
      [_,values,id,checksum] = Regex.run(~r/^((?:[a-z\-]+))(\d+)\[([a-z]{5})\]/, text)
      %{values: values, id: String.to_integer(id), checksum: checksum}
    end

    def get_input(file_name) do
      File.read!(file_name)
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
    end

    def main(file_name) do
      get_input(file_name)
      |> Enum.map(&to_room_info/1)
      |> Enum.filter(&is_valid_room/1)
      |> Enum.map(&decrypt/1)
      |> Enum.filter(&is_where_north_pole_objects_are_stored/1)
      |> Enum.map(&IO.inspect/1)
    end
end

# expected: "very encrypted name"
Day04B.main("day04.input.example2")

Day04B.main("day04.input")
