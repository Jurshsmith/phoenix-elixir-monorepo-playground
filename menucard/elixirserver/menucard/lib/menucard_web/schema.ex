defmodule MenuCardWeb.Schema do
  use Absinthe.Schema

  @desc "An item"
  object :item do
    field :id, :id
    field :name, :string
  end

  # Mock data created with the @constant_name macro
  @menu_items %{
    "foo" => %{id: 1, name: "Pizza"},
    "bar" => %{id: 2, name: "Burger"},
    "foobar" => %{id: 3, name: "PizzaBurger"}
  }

  # Using the Absinthe Module, we must implement this query macro that takes. It contains the resolver
  query do
    field :menu_item, :item do # for queries matching filed menu_item of type :item declared in line 5
      arg :id, non_null(:id) # Simple validation
      resolve fn %{id: item_id}, _ ->
        { :ok, @menu_items[item_id] } # resolved data
      end
    end
  end
end
