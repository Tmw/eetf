Code.require_file("test/test_helper.ex")

# cases =
# for {type, value} <- TestData.values(), reduce: %{} do
# acc ->
# encoded = :erlang.term_to_binary(value)

# acc
# |> Map.put("#{type} (builtin)", fn -> :erlang.binary_to_term(encoded) end)
# |> Map.put("#{type} (handrolled)", fn -> ErlangTermFormat.decode(encoded) end)
# end

Benchee.run(
  %{
    "builtin" => fn input -> :erlang.binary_to_term(input) end,
    "handrolled" => fn input -> ErlangTermFormat.decode(input) end
  },
  inputs: TestData.values() |> Enum.map(fn {k, v} -> {k, :erlang.term_to_binary(v)} end)
)
