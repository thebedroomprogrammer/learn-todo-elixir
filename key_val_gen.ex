defmodule KeyVal do
  use GenServer

  def start do
    GenServer.start(__MODULE__,nil,name: __MODULE__)
  end

  def init(_) do
    {:ok,%{}}
  end

  def put(key,value) do
    GenServer.cast(__MODULE__, {:put,key,value})
  end

  def del(key) do
    GenServer.cast(__MODULE__, {:delete,key})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:fetch,key})
  end

  def handle_call({:fetch,key},_,state) do
    {:reply,Map.fetch(state,key),state}
  end

  def handle_cast({:delete,key},state) do
    {:noreply,Map.delete(state,key)}
  end

  def handle_cast({:put,key,value},state) do
    {:noreply,Map.put(state,key,value)}
  end

end
