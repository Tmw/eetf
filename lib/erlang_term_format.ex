defmodule ErlangTermFormat do
  @version_tag 131
  @string_tag 109
  @small_int_tag 97
  @big_int_tag 98
  @atom_tag 100
  @empty_list_tag 106
  @list_tag 108
  @map_tag 116

  def decode(<<@version_tag, rest::binary()>>) do
    decode(rest)
  end

  def decode(<<@string_tag, length::size(32), bin::binary-size(length), rest::binary()>>) do
    {"#{bin}", rest}
  end

  def decode(<<@small_int_tag, small_int::size(8), rest::binary()>>) do
    {small_int, rest}
  end

  def decode(<<@big_int_tag, big_int::size(32), rest::binary()>>) do
    {big_int, rest}
  end

  def decode(<<@atom_tag, length::size(16), atom::binary-size(length), rest::binary()>>) do
    {String.to_atom(atom), rest}
  end

  def decode(<<@empty_list_tag, rest::binary()>>) do
    {[], rest}
  end

  def decode(<<@list_tag, length::size(32), data::binary>>) do
    for _i <- 1..length, reduce: {[], data} do
      {items, data} ->
        case decode(data) do
          {item, <<106>>} -> {items ++ [item], ""}
          {item, rest} -> {items ++ [item], rest}
        end
    end
  end

  def decode(<<@map_tag, length::size(32), data::binary>>) do
    for _i <- 1..length, reduce: {%{}, data} do
      {map, data} ->
        {key, data} = decode(data)
        {val, data} = decode(data)
        {Map.put(map, key, val), data}
    end
  end

  def decode(other) do
    raise "Not recognized: #{other}"
  end
end
