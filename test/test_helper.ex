ExUnit.start()

defmodule TestData.Person do
  defstruct ~w(name age)a
end

defmodule TestData do
  alias __MODULE__.Person

  @values %{
    string: "simple string",
    atom: :an_atom,
    int_8: 12,
    int32: 512,
    empty_list: [],
    non_empty_list: ["thing one", "thing two"],
    map: %{"lang" => "elixir"},
    struct: %Person{name: "Test", age: 25}
  }

  def values do
    @values
  end
end
