defmodule Coderforum.Users.Create do
  alias Coderforum.{User, Repo}

  def call(params) do
    params
    |> User.build()
    |> create_user()
  end

  defp create_user({:ok, struct}), do: Repo.insert(struct)
  defp create_user({:error, _changeset} = error), do: error
end
