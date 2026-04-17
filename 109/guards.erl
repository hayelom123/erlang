-module(guards).
-export([old_enough_to_drive/1, right_to_vote/1, wrong_age/1]).

% Guards are a powerful feature in Erlang that allow you to add additional conditions to pattern matching.
% They are used in function definitions, case expressions, and receive blocks to specify additional conditions that must be met for a pattern to match.
% Guards are defined using the when keyword followed by a boolean expression that must evaluate to true for the pattern to match.
% For example, you can use guards to check if a number is positive, negative, or zero in a function definition.
% Guards can also be used to check the type of a variable, such as whether it is an integer, a list, or a tuple.
% Guards can be combined using logical operators such as andalso and orelse to create more complex conditions.
% Guards are evaluated after the pattern matching is successful, so they can be used to add additional constraints to the matched values.
% If a guard fails, the next pattern will be tried until a match is found or all patterns have been exhausted.
% Guards are a fundamental concept in Erlang and are used extensively in the language to write concise and efficient code.

old_enough_to_drive(Age) when Age >= 18 -> true;
old_enough_to_drive(_) -> false.

right_to_vote(Age) when Age >= 18, Age =< 120 -> true;
right_to_vote(_) -> false.

% The comma (,) acts in a similar manner to the operator andalso and the semicolon (;) acts a bit like orelse

wrong_age(Age) when Age < 0; Age > 120 ->
    io:format("Invalid age: ~p. Age must be between 0 and 120.~n", [Age]);
wrong_age(_) ->
    io:format("Age is valid.~n").
