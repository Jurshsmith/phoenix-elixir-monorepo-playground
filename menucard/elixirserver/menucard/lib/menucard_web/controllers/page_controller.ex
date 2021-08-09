defmodule MenucardWeb.PageController do
  use MenucardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
