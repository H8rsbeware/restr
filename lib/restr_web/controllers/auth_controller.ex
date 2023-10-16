defmodule RestrWeb.AuthController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  import Plug.Conn


  use RestrWeb, :controller


  action_fallback RestrWeb.FallbackController


  def init(params), do: params

  def call(conn, _params) do
    conn
    |> get_token()
    |> verify_token()
    |> case do
      {:ok, user_id} -> assign(conn, :current_user, user_id)
      _unauthorised -> assign(conn, :current_user, nil)
    end
  end

  def auth_api_user(conn, _params) do
    if Map.get(conn.assigns, :current_user) do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(RestrWeb.ErrorView)
      |> render(:"401")
      |> halt()
    end
  end

  def token_gen(user_id) do
    Phoenix.Token.sign(
      RestrWeb.Endpoint,
      inspect(__MODULE__),
      user_id
    )
  end

  def get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["restr@"<> token] -> token
      _ -> nil
    end
  end
  def verify_token(token) do
    fifthteen_days = 15 * 24 * 60 * 60
    #               days hours min secs

    Phoenix.Token.verify(
      RestrWeb.Endpoint,
      inspect(__MODULE__),
      token,
      max_age:  fifthteen_days
    )
  end
end
