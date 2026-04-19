-module(messages).
-export([dolphine/0, send/2]).

dolphine() ->
    io:format("Dolphine is swimming in the ocean!~n"),
    receive
        do_flip ->
            io:format("Dolphine does a flip!~n"),
            dolphine();
        do_jump ->
            io:format("Dolphine jumps out of the water!~n"),
            dolphine();
        stop ->
            io:format("Dolphine is stopping. Goodbye!~n"),
            ok;
        _ ->
            io:format("Dolphine doesn't understand the command. Try again.~n"),
            dolphine()
    end.

send(Pid, Command) ->
    Pid ! Command.
