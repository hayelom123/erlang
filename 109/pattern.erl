-module(pattern).

% Pattern matching is a powerful feature in Erlang that allows you to match and extract values from data structures.
% It is commonly used in function definitions, case expressions, and receive blocks.
% In function definitions, you can use pattern matching to define multiple clauses for a function, each with different patterns. The function will execute the first clause that matches the input arguments.
% In case expressions, you can use pattern matching to match different patterns against a value and execute the corresponding code for each pattern.
% In receive blocks, you can use pattern matching to match incoming messages against different patterns and execute the corresponding code for each pattern.
% Pattern matching can also be used to extract values from data structures. For example, you can match a tuple against a pattern to extract its elements.
% Pattern matching is a fundamental concept in Erlang and is used extensively in the language to write concise and efficient code.

-export([greet/2]).

greet(male, Name) ->
    io:format("Hello, Mr. ~s!~n", [Name]);
greet(female, Name) ->
    io:format("Hello, Ms. ~s!~n", [Name]);
greet(_, Name) ->
    io:format("Hello, ~s!~n", [Name]).
