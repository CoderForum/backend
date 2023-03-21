defmodule CoderforumWeb.UsersController do
  use CoderforumWeb, :controller

  action_fallback CoderforumWeb.FallbackController

  def create(conn, params) do
    params
    |> Coderforum.create_user()
    |> CoderforumWeb.Util.handle_user_response(conn)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Coderforum.get_user_by_id(id) do
      CoderforumWeb.Util.handle_user_response({:ok, user}, conn)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _user} <- Coderforum.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, user} <- Coderforum.update_user(params) do
      CoderforumWeb.Util.handle_user_response({:ok, user}, conn)
    end
  end
end
