defmodule Coderforum.Users.Update do
  alias Coderforum.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> do_update(user_schema, params)
    end
  end

  defp do_update(%User{} = user, params) do
    user
    |> User.changeset_to_update(params)
    |> Repo.update()
  end
end
