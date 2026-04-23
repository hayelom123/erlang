-module(event).
% ignore this file, it is just for testing the server
-compile(export_all).

-record(state, {
    server,
    name = "",
    to_go = 0
}).
start(EventName, Delay) ->
    spawn(?MODULE, init, [self(), EventName, Delay]).
start_link(EventName, Delay) ->
    spawn_link(?MODULE, init, [self(), EventName, Delay]).

%% Because Erlang is limited to about 49 days (49*24*60*60*1000) in
%% milliseconds, the following function is used.
normalize(N) ->
    Limit = 49 * 24 * 60 * 60,
    [N rem Limit | lists:duplicate(N div Limit, Limit)].

loop(S = #state{server = Server}) ->
    receive
        {Server, Ref, cancel} ->
            Server ! {Ref, ok}
    after S#state.to_go * 1000 ->
        Server ! {done, S#state.name}
    end.
%%% event's innards
init(Server, EventName, Delay) ->
    loop(#state{
        server = Server,
        name = EventName,
        to_go = normalize(Delay)
    }).

cancel(Pid) ->
    %% Monitor in case the process is already dead.
    Ref = erlang:monitor(process, Pid),
    Pid ! {self(), Ref, cancel},
    receive
        {Ref, ok} ->
            erlang:demonitor(Ref, [flush]),
            ok;
        {'DOWN', Ref, process, Pid, _Reason} ->
            ok
    end.
