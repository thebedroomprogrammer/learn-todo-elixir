defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def init(_) do
    {:ok, Todo.List.new()}
  end

  def add(pid,id,task) do
    GenServer.cast(pid, {:add,id,task})
  end

  def delete(pid,id) do
    GenServer.cast(pid, {:delete,id})
  end

  def get(pid,id) do
    GenServer.call(pid, {:get,id})
  end

  def handle_cast({:add, key, value}, state) do
    {:noreply, Todo.List.add(state, key, value)}
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, Todo.List.delete(state, key)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Todo.List.get(state, key), state}
  end
end
