defmodule Todo.List do
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
