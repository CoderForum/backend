defmodule Coderforum do
  defdelegate create_user(params), to: Coderforum.Users.Create, as: :call
  defdelegate get_user_by_id(id), to: Coderforum.Users.Get, as: :by_id
  defdelegate delete_user(id), to: Coderforum.Users.Delete, as: :call
  defdelegate update_user(params), to: Coderforum.Users.Update, as: :call
end
