defmodule ReviewCast.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: ReviewCast.Worker.start_link(arg1, arg2, arg3)
      # worker(ReviewCast.Worker, [arg1, arg2, arg3]),
      supervisor(ReviewCast.Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReviewCast.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
