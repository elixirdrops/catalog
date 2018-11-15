defmodule Catalog.CartTest do
  use ExUnit.Case, async: true

  alias Catalog.Rules.Marketing
  alias Catalog.Rules.Bundle


  describe "Catalog.Rule" do
    test "duplicate rules" do
      assert :ok == Catalog.Cart.rule(Marketing)
      assert :ok == Catalog.Cart.rule(Marketing)
      assert :ok == Catalog.Cart.rule(Bundle)
      assert :ok == Catalog.Cart.rule(Bundle)

      {:ok, rules} = Catalog.Cart.rules()

      assert Enum.count(rules) == 2
    end
  end


  test "add product to cart" do
    Catalog.Cart.clear()

    p1 = %Catalog.Product{
      name: "Product 1",
      price: 10.00
    }

    p2 = %Catalog.Product{
      name: "Product 2",
      price: 30.00
    }

    Catalog.Cart.add(p1)
    Catalog.Cart.add(p2)

    assert Enum.count(Catalog.Cart.items()) == 2
  end

  test "checkout with total" do
    p1 = %Catalog.Product{
      name: "Product 1",
      price: 10.00
    }

    p2 = %Catalog.Product{
      name: "Product 2",
      price: 30.00
    }

    p3 = %Catalog.Product{
      name: "Product 3",
      price: 20.50
    }

    Catalog.Cart.add(p1)
    Catalog.Cart.add(p2)
    Catalog.Cart.add(p3)

    assert Catalog.Cart.total() == 60.5
  end

end
