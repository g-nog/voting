defmodule VotingWeb.Admin.SessionControllerTest do
  use VotingWeb.ConnCase, async: true

  import Voting.Factory

  describe "create/2" do
    setup %{conn: conn} do
      insert(:admin, name: "John Smith", email: "john@gmail.com")
      %{conn: conn}
    end

    test "returns 200 when credentials are valid" do
      res =
        post(build_conn(), "/api/v1/admin/sign_in", %{
          "email" => "john@gmail.com",
          "password" => "123456"
        })

      assert %{
               "status" => "ok",
               "data" => %{
                 "name" => "John Smith",
                 "token" => _
               }
             } = json_response(res, 200)
    end

    test "returns 401 when email is invalid" do
      res =
        post(build_conn(), "/api/v1/admin/sign_in", %{
          "email" => "johnX@gmail.com",
          "password" => "123456"
        })

      assert %{"status" => "unauthenticated"} = json_response(res, 401)
    end

    test "returns 401 when password is invalid" do
      res =
        post(build_conn(), "/api/v1/admin/sign_in", %{
          "email" => "john@gmail.com",
          "password" => "X123456"
        })

      assert %{"status" => "unauthenticated"} = json_response(res, 401)
    end
  end
end
