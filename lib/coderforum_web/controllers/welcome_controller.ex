defmodule CoderforumWeb.WelcomeController do
  use CoderforumWeb, :controller

  action_fallback CoderforumWeb.FallbackController

  def index(conn, _) do
    conn
    |> put_status(:ok)
    |> text("OK")
  end
end
