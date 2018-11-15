defmodule Catalog.Cart do

  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_state) do
    {:ok, %{}}
  end

  def add(product) do
    GenServer.cast(__MODULE__, {:add, product})
  end

  def total() do
    GenServer.call(__MODULE__, :total)
  end

  def items() do
    GenServer.call(__MODULE__, :items)
  end

  def handle_call(:total, _from, state) do
    sum = state
    |> Enum.map(fn {_, p} -> p.price end)
    |> Enum.sum

    {:reply, sum, state}
  end

  def handle_call(:items, _from, state) do
    {:reply, Map.to_list(state), state}
  end

  def handle_cast({:add, product}, state) do
    newState = Map.put(state, product.name, product)
    {:noreply, newState}
  end

end
