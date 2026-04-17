-module(higher_order).
-export([map/2, setAlarm/1]).

% higher order functions are functions that can take other functions as arguments or return functions as results.
% In Erlang, higher order functions are commonly used to create more flexible and reusable code.
% For example, the map function is a higher order function that takes a list and a function as arguments
% and applies the function to each element of the list, returning a new list with the results.

% An important part of all functional programming
% languages is the ability to take a function you defined
% and then pass it as a parameter to another function.
% This binds that function parameter to a variable,
% which can be used like any other variable within the function. A function
% that can accept other functions transported around this way is called a
% higher-order function. As you’ll learn in this chapter, higher-order functions
% are a powerful means of abstraction and one of the best tools to master in
% Erlang.

map(_, []) -> [];
map(F, [H | T]) -> [F(H) | map(F, T)].

setAlarm(Time) ->
    io:format("Alarm set for ~p~n", [Time]),
    fun() ->
        io:format("Alarm is ringing! it's ~p~n", [Time])
    end.
