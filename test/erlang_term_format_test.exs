defmodule TestPerson do
  defstruct ~w(name age)a
end

defmodule ErlangTermFormatTest do
  use ExUnit.Case
  TestData.values()

  for {key, value} <- TestData.values() do
    @key key
    @value value

    test "decodes #{@key}" do
      encoded = :erlang.term_to_binary(@value)
      assert {@value, ""} = ErlangTermFormat.decode(encoded)
    end
  end
end
