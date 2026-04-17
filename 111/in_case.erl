-module(in_case).
-export([beach/1, is_favorable/1]).

% In Erlang, the case expression is used to handle multiple conditions and execute different code based on the value of a variable.
% The case expression evaluates a value and matches it against a series of patterns. Each pattern is followed by an arrow (->) and the code to execute if the pattern matches.
% The case expression is similar to a switch statement in other programming languages, but it is more powerful because it allows    for pattern matching and guards.
% The case expression is often used in situations where you want to handle different cases based on the value of a variable, such as in error handling or when processing different types of data.
% The case expression can also be used to extract values from data structures, such as tuples or lists, by matching against specific patterns.
% Overall, the case expression is a fundamental construct in Erlang that allows for flexible and efficient handling of multiple conditions and data structures.

beach(Temperature) ->
    case Temperature of
        T when T < 15 ->
            "It's too cold for the beach!";
        T when T >= 15, T =< 25 ->
            "The weather is perfect for the beach!";
        T when T > 25 ->
            "It's too hot for the beach!"
    end.

is_favorable(Temperature) ->
    case Temperature of
        {celsius, T} when T >= 15, T =< 25 ->
            "The weather is perfect for the beach!";
        {fahrenheit, T} when T >= 59, T =< 77 ->
            "The weather is perfect for the beach!";
        _ ->
            "The weather is not favorable for the beach!"
    end.
