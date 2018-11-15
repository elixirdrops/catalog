defmodule Catalog.Cart do

  use GenServer

  defstruct [rules: %{}, products: %{}]

  @name __MODULE__

  def start_link(state) do
    GenServer.start_link(@name, state, name: @name)
  end

  def init(_state) do
    {:ok, create_cart()}
  end

  def create_cart() do
    %Catalog.Cart{
      rules: %{},
      products: %{}
    }
  end

  def add(product) do
    GenServer.cast(@name, {:add, product})
  end

  def total() do
    GenServer.call(@name, :total)
  end

  def items() do
    GenServer.call(@name, :items)
  end

  def rule(r) do
    GenServer.cast(@name, {:rule, r})
  end

  def rules() do
    {:ok, [1, 2]}
  end

  def clear() do
    GenServer.cast(@name, :clear)
  end

  def handle_call(:total, _from, state) do
    sum = state
    |> Map.get(:products)
    |> Enum.map(fn {_, p} -> p.price end)
    |> Enum.sum

    {:reply, sum, state}
  end

  def handle_call(:items, _from, state) do
    items = state
    |> Map.get(:products)
    |> Map.to_list()

    {:reply, items, state}
  end

  def handle_cast({:add, product}, state) do
    products =
      Map.get(state, :products)
      |> Map.put(product.name, product)

    newState = Map.put(state, :products, products)

    {:noreply, newState}
  end

  def handle_cast(:clear, _state) do
    {:noreply, create_cart()}
  end

  def handle_cast({:rule, rule}, state) do
    rules = 
      Map.get(state, :rules)
      |> Map.put(to_string(rule), rule)

    newState = Map.put(state, :rules, rules)

    {:noreply, newState}
  end

end
