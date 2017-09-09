defmodule TodoAppWeb.TodoIntegrationTest do
  use TodoAppWeb.IntegrationCase

  import WuffWuff.Api
  import TodoAppWeb.AuthCase

  setup do
    user = add_user("ted@mail.com")
    other = add_user("frank@mail.com")
    %{"access_token" => token} = login_user("ted@mail.com")
    {:ok, %{user: user, other: other, token: token}}
  end

  test "can create todo for self", %{user: %{id: id}, token: token} do
    todo = %{body: "Need to find the meaning of life",
      notes: "Have to finish by next Wednesday",
      title: "Search for meaning"}
    %{"data" => data} = post!("/users/#{id}/todos", %{todo: todo}, ~a(#{token})).body
    assert data["body"] =~ "meaning of life"
    assert data["notes"] =~ "finish by next Wednesday"
  end

end
