-module(what_if).
-export([works_fine/1, help_me/1]).

% about if statements in erlang
% Erlang does not have traditional if statements like other programming languages.
% Instead, it uses pattern matching and guards to achieve similar functionality.
% In Erlang, you can use case expressions or function clauses with guards to handle different conditions.
% For example, you can use a case expression to check the value of a variable and execute different code based on the value.
% You can also use function clauses with guards to define different behaviors for a function based on the input arguments.
% This approach allows for more flexible and concise code, as you can handle multiple conditions in a single function definition without the need for nested if statements.
% Overall, while Erlang does not have traditional if statements,
% it provides powerful tools for handling conditional logic through pattern matching and guards.
% if statement needs to return a value, and it must have an else clause to handle the case when the condition is false.

works_fine(N) ->
    if
        N > 0 ->
            whole_Number;
        true ->
            not_a_whole_number
    end.
help_me(Animal) ->
    Talk =
        if
            Animal == dog ->
                "Woof!";
            Animal == cat ->
                "Meow!";
            true ->
                "I don't know that animal."
        end,
    io:format("The ~p says: ~p~n", [Animal, Talk]).
