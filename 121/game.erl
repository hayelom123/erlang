-module(game).

-export([add_player/2, add_score/2, get_players/0, get_player/1, start_game/0, start/0]).
-record(player, {name, score}).
-record(state, {players = []}).

add_player_to_state(State, #player{name = Name, score = Score}) ->
    Player = #player{name = Name, score = Score},
    State#state{players = [Player | State#state.players]}.

add_score(State, Name, Score) ->
    Players = State#state.players,
    UpdatedPlayers = lists:map(
        fun(Player) ->
            case Player#player.name of
                Name -> Player#player{score = Player#player.score + Score};
                _ -> Player
            end
        end,
        Players
    ),
    State#state{players = UpdatedPlayers}.
get_players(State) ->
    State#state.players.
get_player(State, Name) ->
    lists:filter(fun(Player) -> Player#player.name =:= Name end, State#state.players).
start() ->
    Pid = spawn(?MODULE, start_game, []),
    io:format("Game started with PID: ~p~n", [Pid]),
    register(mygame, Pid).

start_game() ->
    loop(#state{}).

loop(State) ->
    % io:format("Current Players: ~p~n", [State#state.players]),
    receive
        {add_player, Name, Score} ->
            NewState = add_player_to_state(State, #player{name = Name, score = Score}),
            io:format("Player added: ~s with score ~p~n", [Name, Score]),
            loop(NewState);
        {add_score, Name, Score} ->
            NewState = add_score(State, Name, Score),
            io:format("Score added to ~s: ~p~n", [Name, Score]),
            loop(NewState);
        {get_players, Caller} ->
            Caller ! {players, get_players(State)},
            loop(State);
        {get_player, Name, Caller} ->
            Caller ! {player, get_player(State, Name)},
            loop(State);
        stop ->
            io:format("Game stopped.~n");
        _ ->
            io:format("Unknown message received.~n"),
            loop(State)
    end.

get_players() ->
    mygame ! {get_players, self()},
    receive
        {players, Players} -> Players
    end.
get_player(Name) ->
    mygame ! {get_player, Name, self()},
    receive
        {player, Player} -> Player
    end.
add_player(Name, Score) ->
    mygame ! {add_player, Name, Score}.
add_score(Name, Score) ->
    mygame ! {add_score, Name, Score}.
