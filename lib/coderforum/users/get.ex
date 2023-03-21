defmodule Coderforum.Users.Get do
  alias Coderforum.{Repo, User, Error}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> {:ok, user_schema}
    end
  end
end
