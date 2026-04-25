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
    Pid = start_game(),
    register(mygame, Pid),
    io:format("Supervisor started game: ~p~n", [Pid]),
    loop().

start_game() ->
    spawn_link(game, start_game, []).

loop() ->
    receive
        {'EXIT', Prid, Reason} ->
            % io:format("Game process with PID ~p exited with reason: ~p~n", [Prid, Reason]),
            io:format("💀 Game died: ~p~n", [{{pid, Prid}, {reason, Reason}}]),
            io:format("🔁 Restarting game...~n"),
            NewPid = start_game(),
            register(mygame, NewPid),
            io:format("✅ Game restarted with PID: ~p~n", [NewPid]),
            loop();
        stop ->
            io:format("Game supervisor stopped.~n");
        _ ->
            loop()
    end.
