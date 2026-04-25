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
            io:format("Received data: ~p~n", [Data]),
            gen_tcp:send(
                Client, <<"HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello from Erlang!">>
            ),
            gen_tcp:close(Client);
        {error, closed} ->
            io:format("Client disconnected: ~p~n", [Client]);
        {error, Reason} ->
            io:format("Error receiving data from client ~p: ~p~n", [Client, Reason])
    end,
    gen_tcp:close(Client).
