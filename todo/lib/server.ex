defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil,name: __MODULE__)
  end

  def init(_) do
    {:ok, Todo.List.new()}
  end

  def add(id,task) do
    GenServer.cast(__MODULE__, {:add,id,task})
  end

  def delete(id) do
    GenServer.cast(__MODULE__, {:delete,id})
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get,id})
  end

  def handle_cast({:add, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.fetch(state,key), state}
  end
end
