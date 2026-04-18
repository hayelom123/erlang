-module(functionality).
-export([greet/0]).

greet() ->
    io:format("Hello, World!~n").
