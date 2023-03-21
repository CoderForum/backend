defmodule CoderforumWeb.Util do
  import Plug.Conn

  @spec respond({:ok}, Plug.Conn.t()) :: Plug.Conn.t()
  def respond({:ok}, conn) do
    conn
    |> send_resp(204, "")
  end

  @spec respond({:ok, any}, Plug.Conn.t()) :: Plug.Conn.t()
  def respond({:ok, data}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{success: true, data: data}))
  end

  @spec respond({:error, atom, binary}, Plug.Conn.t()) :: Plug.Conn.t()
  def respond({:error, code, reason}, conn) do
    respond({:error, 404, code, reason}, conn)
  end

  @spec respond({:error, integer, atom, binary}, Plug.Conn.t()) :: Plug.Conn.t()
  def respond({:error, http_code, code, reason}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      http_code,
      Poison.encode!(%{
        success: false,
        error: %{
          code: Atom.to_string(code),
          message: reason
        }
      })
    )
  end

  @spec handle_user_response({:ok, %Coderforum.User{}}, Plug.Conn.t()) :: Plug.Conn.t()
  def handle_user_response({:ok, user}, conn) do
    respond(
      {:ok,
       %{
         id: user.id,
         username: user.username,
         full_name: user.full_name,
         bio: user.bio,
         email: user.email
       }},
      conn
    )
  end

  def handle_user_response({:error, _changeset} = error, _conn), do: error
end
