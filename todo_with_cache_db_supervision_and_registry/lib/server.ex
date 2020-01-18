defmodule Todo.Server do
  use GenServer

  def start_link(name) do
    IO.puts("Starting to-do worker.")
    GenServer.start_link(__MODULE__, name)
  end

  def init(name) do
    {:ok, {name, Todo.Database.get(name) || Todo.List.new()}}
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

  def handle_cast({:add, key, value}, {name,state}) do
    new_list = Todo.List.add(state, key, value)
    Todo.Database.store(name, new_list)
    {:noreply, {name,new_list}}
  end

  def handle_cast({:delete, key}, {state}) do
    {:noreply, Todo.List.delete(state, key)}
  end

  def handle_call({:get, key}, _, {name,state}) do
    {:reply, Todo.List.get(state, key), {name,state}}
  end
end
