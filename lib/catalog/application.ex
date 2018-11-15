defmodule Catalog.Application do

  use Application

  def start(_type, _args) do
    children = [
      Catalog.Cart
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
