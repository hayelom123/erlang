-module(game_sup).

-export([start/0, loop/0]).

start() ->
    Pid = spawn(?MODULE, loop, []),
    register(game_sup, Pid),
    {ok, Pid}.

loop() ->
    process_flag(trap_exit, true),
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
