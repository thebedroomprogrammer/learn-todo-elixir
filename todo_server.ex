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
