defmodule TodoServer do
  def start() do
    spawn(fn ->
      Process.register(self(), :todo_server)
      loop(TodoList.new()) end)
  end

  def add_entry(id,task) do
    send(:todo_server, {:add, id, task})
  end

  def delete(id) do
    send(:todo_server, {:delete, id})
  end

  def get(id) do
    send(:todo_server, {:get, id,self()})
    receive do
      {:found_id, task} -> task
     after
      5000 -> {:error, :timeout}
    end
  end

  def process_message(todo_list,{:add,id,task}) do
    TodoList.add_entry(todo_list,id,task)
  end

  def process_message(todo_list,{:delete,id}) do
    TodoList.delete(todo_list,id)
  end

  def process_message(todo_list,{:get,id,caller}) do
    send(caller,{:found_id, TodoList.entries(todo_list,id)})
    todo_list
  end

  def loop(todo_list) do
    new_list = receive do
      message -> process_message(todo_list,message)
    end
    loop(new_list)
  end
end

defmodule TodoList do
  def new() do
    %{}
  end

  def add_entry(todo_list,id,task) do
    Map.update(todo_list, id, [task], fn tasks -> [task | tasks] end)
  end

  def entries(todo_list,id) do
    Map.get(todo_list, id, [])
  end

  def delete(todo_list,id) do
    Map.delete(todo_list, id)
  end

end
