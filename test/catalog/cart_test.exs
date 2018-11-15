defmodule Catalog.CartTest do
  use ExUnit.Case, async: true

  test "add product to cart" do
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

    assert length(Catalog.Cart.items()) == 2
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
