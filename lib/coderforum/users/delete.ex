defmodule Coderforum.Users.Delete do
  alias Coderforum.{Repo, User, Error}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> Repo.delete(user_schema)
    end
  end
end
