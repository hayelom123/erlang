-module(routes).
-export([setup/0]).

setup() ->
    Router0 = router:new(),

    %% GET / -> Home
    R1 = router:add_route(
        <<"GET">>,
        <<"/">>,
        fun(_Req, _Params) -> {ok, <<"Welcome to Erlang Express!">>} end,
        Router0
    ),

    %% GET /hello/:name
    R2 = router:add_route(
        <<"GET">>,
        <<"/hello/:name">>,
        fun(_Req, #{name := Name}) ->
            {ok, <<<<"Hello, ">>/binary, Name/binary, <<"!">>/binary>>}
        end,
        R1
    ),

    %% GET /users/:id/posts/:postId
    R3 = router:add_route(
        <<"GET">>,
        <<"/users/:id/posts/:postId">>,
        fun(_Req, #{id := UserId, postId := PostId}) ->
            Response = iolist_to_binary([
                "User: ", UserId, ", Post: ", PostId
            ]),
            {ok, Response}
        end,
        R2
    ),

    %% POST /users
    R4 = router:add_route(
        <<"POST">>,
        <<"/users">>,
        fun(Req, _Params) ->
            %% You could parse body here
            {ok, <<"User created!">>}
        end,
        R3
    ),

    %% 404 fallback
    router:add_route(
        <<"*">>,
        <<"*">>,
        fun(_Req, _Params) -> {error, 404, <<"Not Found">>} end,
        R4
    ).
