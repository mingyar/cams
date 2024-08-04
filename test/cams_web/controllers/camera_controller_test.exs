defmodule CamsWeb.CameraControllerTest do
  use CamsWeb.ConnCase

  import Cams.CamerasFixtures

  alias Cams.Cameras.Camera

  @create_attrs %{
    status: true,
    brand: "some brand"
  }
  @update_attrs %{
    status: false,
    brand: "some updated brand"
  }
  @invalid_attrs %{status: nil, brand: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cameras", %{conn: conn} do
      conn = get(conn, ~p"/api/cameras")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create camera" do
    test "renders camera when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/cameras", camera: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/cameras/#{id}")

      assert %{
               "id" => ^id,
               "brand" => "some brand",
               "status" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/cameras", camera: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update camera" do
    setup [:create_camera]

    test "renders camera when data is valid", %{conn: conn, camera: %Camera{id: id} = camera} do
      conn = put(conn, ~p"/api/cameras/#{camera}", camera: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cameras/#{id}")

      assert %{
               "id" => ^id,
               "brand" => "some updated brand",
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, camera: camera} do
      conn = put(conn, ~p"/api/cameras/#{camera}", camera: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete camera" do
    setup [:create_camera]

    test "deletes chosen camera", %{conn: conn, camera: camera} do
      conn = delete(conn, ~p"/api/cameras/#{camera}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/cameras/#{camera}")
      end
    end
  end

  defp create_camera(_) do
    camera = camera_fixture()
    %{camera: camera}
  end
end
