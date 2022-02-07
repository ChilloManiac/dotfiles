defmodule ElixirSense.Server.TCPServer do
  use Bitwise

  alias ElixirSense.Server.{RequestHandler, ContextLoader}

  @connection_handler_supervisor ElixirSense.Server.TCPServer.ConnectionHandlerSupervisor
  @default_listen_options [:binary, active: false, reuseaddr: true, packet: 4]

  def start([socket_type: socket_type, port: port, env: env]) do
    import Supervisor.Spec

    children = [
      worker(Task, [__MODULE__, :listen, [socket_type, "localhost", port]]),
      supervisor(Task.Supervisor, [[name: @connection_handler_supervisor]]),
      worker(ContextLoader, [env])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

  def listen(socket_type, host, port) do
    {port_or_file, opts} = listen_options(socket_type, port)
    {:ok, socket} = :gen_tcp.listen(port_or_file, opts)
    {:ok, port_or_file} = :inet.port(socket)
    auth_token = create_auth_token(socket_type)

    socket_type
    |> format_output(host, port_or_file, auth_token)
    |> IO.puts

    accept(socket, auth_token)
  end

  defp create_auth_token("tcpip") do
    :base64.encode(:crypto.strong_rand_bytes(64))
  end
  defp create_auth_token("unix") do
    nil
  end

  defp format_output("tcpip", host, port, auth_token) do
    "ok:#{host}:#{port}:#{auth_token}"
  end
  defp format_output("unix", host, file, _auth_token) do
    "ok:#{host}:#{file}"
  end

  defp listen_options("tcpip", port) do
    {String.to_integer(port), @default_listen_options ++ [ip: {127,0,0,1}]}
  end
  defp listen_options("unix", _port) do
    {0, @default_listen_options ++ [ifaddr: {:local, socket_file()}]}
  end

  defp accept(socket, auth_token) do
    {:ok, client_socket} = :gen_tcp.accept(socket)
    {:ok, pid} = start_connection_handler(client_socket, auth_token)
    :ok = :gen_tcp.controlling_process(client_socket, pid)

    accept(socket, auth_token)
  end

  defp start_connection_handler(client_socket, auth_token) do
    Task.Supervisor.start_child(@connection_handler_supervisor, fn ->
      connection_handler(client_socket, auth_token)
    end)
  end

  defp connection_handler(socket, auth_token) do
    case :gen_tcp.recv(socket, 0) do
      {:error, :closed} ->
        IO.puts :stderr, "Client socket is closed"
      {:ok, data} ->
        data
        |> process_request(auth_token)
        |> send_response(socket)
        connection_handler(socket, auth_token)
    end
  end

  defp process_request(data, auth_token) do
    try do
      data
      |> :erlang.binary_to_term()
      |> dispatch_request(auth_token)
      |> :erlang.term_to_binary()
    rescue
      e ->
        IO.puts(:stderr, "Server Error: \n" <> Exception.message(e) <> "\n" <> Exception.format_stacktrace(System.stacktrace))
        :erlang.term_to_binary(%{request_id: nil, payload: nil, error: Exception.message(e)})
    catch
      e ->
        error = "Uncaught value #{inspect(e)}"
        IO.puts(:stderr, "Server Error: #{error}\n" <> Exception.format_stacktrace(System.stacktrace))
        :erlang.term_to_binary(%{request_id: nil, payload: nil, error: error})
    end
  end

  defp dispatch_request(%{ "request_id" => request_id, "auth_token" => req_token, "request" => request, "payload" => payload }, auth_token) do
    if secure_compare(auth_token, req_token) do
      ContextLoader.reload()
      payload = RequestHandler.handle_request(request, payload)
      %{request_id: request_id, payload: payload, error: nil }
    else
      %{request_id: request_id, payload: nil, error: "unauthorized" }
    end
  end

  defp send_response(data, socket) do
    :gen_tcp.send(socket, data)
  end

  defp socket_file do
    sock_id = :erlang.system_time()
    String.to_charlist("/tmp/elixir-sense-#{sock_id}.sock")
  end

  # Adapted from https://github.com/plackemacher/secure_compare/blob/master/lib/secure_compare.ex
  defp secure_compare(nil, nil), do: true
  defp secure_compare(a, b) when is_nil(a) or is_nil(b), do: false
  defp secure_compare(a, b) when byte_size(a) != byte_size(b), do: false
  defp secure_compare(a, b) when is_binary(a) and is_binary(b) do
    a_list = String.to_char_list(a)
    b_list = String.to_char_list(b)
    secure_compare(a_list, b_list)
  end
  defp secure_compare(a, b) when is_list(a) and is_list(b) do
    res = Enum.zip(a, b) |> Enum.reduce(0, fn({a_byte, b_byte}, acc) ->
      acc ||| bxor(a_byte, b_byte)
    end)
    res == 0
  end
end
