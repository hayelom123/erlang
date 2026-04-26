-module(server).
-export([start/0]).

start() ->
    {ok, Socket} = gen_tcp:listen(8080, [
        binary,
        {packet, 0},
        {active, false},
        {reuseaddr, true}
    ]),
    io:format("Server listening on port http://localhost:8080~n"),
    accept(Socket).

accept(Socket) ->
    {ok, Client} = gen_tcp:accept(Socket),
    io:format("Client connected: ~p~n", [Client]),
    spawn(fun() -> handleClient(Client) end),
    accept(Socket).

handleClient(Client) ->
    case gen_tcp:recv(Client, 0) of
        {ok, Data} ->
            %% Parse the HTTP request using your http_parser module
            case catch http_parser:parse(Data) of
                {'EXIT', Reason} ->
                    io:format("Parse error: ~p~n", [Reason]),
                    send_response(Client, 400, <<"Bad Request">>);
                Parsed ->
                    %% Successfully parsed - log and respond
                    #{method := Method, path := Path, headers := Headers} = Parsed,
                    io:format("Received ~s request for ~s~n", [Method, Path]),
                    % io:format("Headers: ~p~n", [Headers]),

                    %% Simple routing example
                    ResponseBody =
                        case Path of
                            "/hello" -> <<"Hello, World!">>;
                            "/time" -> integer_to_binary(erlang:system_time(second));
                            % Placeholder for dynamic route
                            "/game/:id" -> <<"Game details for ID: ">>;
                            _ -> <<"Hello from Erlang!">>
                        end,
                    send_response(Client, 200, ResponseBody)
            end,
            gen_tcp:close(Client);
        {error, closed} ->
            io:format("Client disconnected: ~p~n", [Client]);
        {error, Reason} ->
            io:format("Error receiving data from client ~p: ~p~n", [Client, Reason]),
            gen_tcp:close(Client)
    end.

%% Helper to send HTTP response
send_response(Client, StatusCode, Body) ->
    StatusText =
        case StatusCode of
            200 -> "OK";
            400 -> "Bad Request";
            404 -> "Not Found";
            _ -> "Internal Server Error "
        end,
    Response = iolist_to_binary([
        "HTTP/1.1 ",
        integer_to_list(StatusCode),
        " ",
        StatusText,
        "\r\n",
        "Content-Type: text/plain\r\n",
        "Content-Length: ",
        integer_to_list(byte_size(Body)),
        "\r\n",
        "\r\n",
        Body
    ]),
    gen_tcp:send(Client, Response).
