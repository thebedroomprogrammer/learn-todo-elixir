defmodule TodoList do
  def new() do
    %{}
  end

  def add_entry(todo_list,date,task) do
    Map.update(todo_list, date, [task], fn tasks -> [task | tasks] end)
  end

  def entries(todo_list,date) do
    Map.get(todo_list, date, [])
  end
end
