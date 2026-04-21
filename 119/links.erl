-module(links).
-export([myproc/0, chain/1]).

myproc() ->
    timer:sleep(1000),
    io:format("My process is done!~n"),
    exit(reason).

chain(0) ->
    receive
        _ -> ok
    after 2000 ->
        exit("Chain dies here")
    end;
chain(N) ->
    Pid = spawn(fun() -> chain(N - 1) end),
    link(Pid),
    receive
        _ -> ok
    end.
