-module(game_sup).

-export([start/0, init/0]).

start() ->
    case whereis(game_sup) of
        undefined ->
            Pid = spawn(?MODULE, init, []),
            register(game_sup, Pid),
            {ok, Pid};
        Pid ->
            io:format("Game supervisor already running with PID: ~p~n", [Pid]),
            {ok, Pid}
    end.

init() ->
    process_flag(trap_exit, true),
    loop().
loop() ->
    case whereis(mygame) of
        undefined ->
            Pid = spawn(game, start_game, []),
            register(mygame, Pid),
            io:format("Game process started with PID: ~p~n", [Pid]);
        Pid ->
            io:format("Game process already running with PID: ~p~n", [Pid])
    end,

    receive
        {'EXIT', Prid, Reason} ->
            io:format("Game process with PID ~p exited with reason: ~p~n", [Prid, Reason]),
            loop();
        stop ->
            io:format("Game supervisor stopped.~n");
        _ ->
            loop()
    end.
