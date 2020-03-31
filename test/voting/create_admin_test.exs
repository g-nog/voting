defmodule Voting.CreateAdminTest do
  use Voting.DataCase, async: true

  alias Voting.{Admin, CreateAdmin}

  describe "run/1" do
    test "returns a structure when the params are valid" do
      params = %{name: "nogs", email: "nogs@nogs.com", password: "123456"}
      assert {:ok, %Admin{} = admin} = CreateAdmin.run(params)
      assert admin.name == "nogs"
      assert admin.email == "nogs@nogs.com"
      assert admin.password_hash != "123456"
    end

    test "returns error when name is missing" do
      params = %{name: "", email: "nogs@nogs.com", password: "123456"}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateAdmin.run(params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when email is missing" do
      params = %{name: "nogs", email: "", password: "123456"}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateAdmin.run(params)
      %{email: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when password is missing" do
      params = %{name: "nogs", email: "nogs@nogs.com", password: ""}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateAdmin.run(params)
      %{password: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
