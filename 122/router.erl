-module(router).
-export([new/0, add_route/4, match/2, extract_params/3]).

%% Router is a list of routes: [{Method, PathPattern, Handler, ParamsSpec}]
-type route() :: {binary(), list(), fun(), list()}.
-type router() :: [route()].

%% Create empty router
new() -> [].

%% Add a route: Method (binary), Path (binary), Handler fun, Options
add_route(Method, Path, Handler, Opts) when is_binary(Method), is_binary(Path) ->
    Pattern = tokenize_path(Path),
    ParamsSpec = extract_param_names(Pattern),
    [{Method, Pattern, Handler, ParamsSpec} | Opts].

%% Match a request: {Method, Path} against router
match({Method, Path}, Routes) when is_binary(Method), is_binary(Path) ->
    PathTokens = tokenize_path(Path),
    match_route(Method, PathTokens, Routes).

match_route(_, _, []) ->
    {not_found, []};
match_route(Method, PathTokens, [{Method, Pattern, Handler, ParamsSpec} | Rest]) ->
    case match_pattern(Pattern, PathTokens, ParamsSpec) of
        {match, Params} -> {ok, Handler, Params};
        no_match -> match_route(Method, PathTokens, Rest)
    end;
match_route(Method, PathTokens, [_ | Rest]) ->
    match_route(Method, PathTokens, Rest).

%% Tokenize path: <<"/users/:id/posts">> -> [<<"users">>, <<":id">>, <<"posts">>]
tokenize_path(Path) ->
    Parts = binary:split(Path, <<"/">>, [global]),
    [P || P <- Parts, P =/= <<>>].

%% Extract param names from pattern: [<<":id">>] -> [<<"id">>]
extract_param_names(Pattern) ->
    [
        binary:part(P, 1, byte_size(P) - 1)
     || P <- Pattern,
        byte_size(P) > 1,
        binary:part(P, 0, 1) =:= <<":">>
    ].

%% Match pattern against actual path tokens, extract params
match_pattern([], [], ParamsSpec) ->
    {match, build_params(ParamsSpec, [])};
match_pattern([P | RestP], [T | RestT], ParamsSpec) ->
    case is_param(P) of
        true ->
            ParamName = binary:part(P, 1, byte_size(P) - 1),
            match_pattern(RestP, RestT, ParamsSpec, ParamName, T);
        false when P =:= T ->
            match_pattern(RestP, RestT, ParamsSpec);
        false ->
            no_match
    end;
match_pattern(_, _, _) ->
    no_match.

%% Helper for param extraction with accumulator
match_pattern(Pat, Path, ParamsSpec, ParamName, Value) ->
    case match_pattern(Pat, Path, ParamsSpec) of
        {match, Params} -> {match, [{ParamName, Value} | Params]};
        no_match -> no_match
    end.

build_params([], Acc) ->
    maps:from_list(Acc);
build_params([Name | Rest], Acc) ->
    %% Only include if we have a value (matched param)
    case lists:keyfind(Name, 1, Acc) of
        {Name, Value} -> build_params(Rest, Acc);
        false -> build_params(Rest, Acc)
    end.

is_param(P) ->
    byte_size(P) > 1 andalso binary:part(P, 0, 1) =:= <<":">>.

%% Public helper: extract params from matched pattern (used internally)
extract_params(Pattern, PathTokens, ParamsSpec) ->
    match_pattern(Pattern, PathTokens, ParamsSpec).
