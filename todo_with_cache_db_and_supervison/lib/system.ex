defmodule Todo.System do

  def init(_) do
    Supervisor.init([Todo.Cache,Todo.Database], strategy: :one_for_one)
  end

  def start_link() do
    Supervisor.start_link(__MODULE__,nil)
  end

end
