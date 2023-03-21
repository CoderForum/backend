defmodule Coderforum.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :email, :string
    field :username, :string
    field :full_name, :string
    field :bio, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @fields_that_can_be_changed [
    :email,
    :username,
    :full_name,
    :bio,
    :password
  ]

  @required_fields [:email, :password, :username]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(struct \\ %__MODULE__{}, params, fields \\ @required_fields) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(fields)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  def changeset_to_update(struct, params) do
    changeset(struct, params, @required_fields -- [:password])
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
