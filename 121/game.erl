-module(game).

-export([add_player/2, add_score/3]).
-record(player, {name, score}).
-record(state, {players = []}).

add_player(State, #player{name = Name, score = Score}) ->
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
