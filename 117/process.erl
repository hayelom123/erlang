-module(process).
-export([start/0, display/1]).

display(X) ->
    timer:sleep(1000),
    io:format("Process ~p: ~p~n", [self(), X]).
start() ->
    [spawn(?MODULE, display, [X]) || X <- lists:seq(1, 100)].
