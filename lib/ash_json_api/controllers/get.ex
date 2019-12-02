defmodule AshJsonApi.Controllers.Get do
  alias AshJsonApi.Controllers.{Helpers, Response}
  alias AshJsonApi.Request

  def init(options) do
    # initialize options
    options
  end

  def call(conn, options) do
    resource = options[:resource]
    action = options[:action]
    api = options[:api]

    conn
    |> Request.from(resource, action, api)
    |> Helpers.fetch_record_from_path()
    |> Helpers.fetch_includes()
    |> Helpers.render_or_render_errors(conn, fn request ->
      Response.render_one(conn, request, 200, request.assigns.result, request.assigns.includes)
    end)
  end
end
