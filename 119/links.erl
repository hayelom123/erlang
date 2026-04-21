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
% After the process running linkmon:chain(0) dies, the error is propagated
% down the chain of links until the shell process itself dies because of it. The
% crash could have happened in any of the linked processes. Because links are
% bidirectional, you need only one of them to die for the others to follow suit.

% Links cannot be stacked. If you call link/1 fifteen times for the same two processes,
% only one link will still exist between those processes, and a single call to unlink/1 will
% be enough to tear it down.
