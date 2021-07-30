defmodule RepoTwoWithPhxWeb.PageController do
  use RepoTwoWithPhxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
