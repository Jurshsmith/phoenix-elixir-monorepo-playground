defmodule CommunityWeb.Schema do
  use Absinthe.Schema

  alias CommunityWeb.NewsResolver

  object :link do
    field :id, non_null(:id)
    filed :url, non_null(:string)
    field :description, non_null(:string)
  end

  query do
    # this is the query entry point to our app
    @desc "Get all links"
    field :all_links, non_null(list_of(non_null(:link))) do
      resolve(&NewsResolver.all_links/3)
    end
  end

end
