defmodule TodoServer do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil,name: __MODULE__)
  end

  def init(_) do
    {:ok, TodoList.new()}
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
    {:noreply, TodoList.add(state, key, value)}
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, TodoList.delete(state, key)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end
end

defmodule TodoList do
  def new() do
    %{}
  end

  def add(todo_list, id, task) do
    Map.update(todo_list, id, [task], fn tasks -> [task | tasks] end)
  end

  def get(todo_list, id) do
    Map.get(todo_list, id, [])
  end

  def delete(todo_list, id) do
    Map.delete(todo_list, id)
  end
end
