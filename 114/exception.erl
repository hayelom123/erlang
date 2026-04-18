-module(exception).
-export([divide/2, errors/1, exits/1, sword/1, black_knight/1]).

% In Erlang, exceptions are used to handle errors and unexpected situations in a controlled manner.
% When an exception occurs, the normal flow of the program is interrupted, and the control is
% transferred to an exception handler. This allows developers to gracefully handle errors and prevent crashes.
% There are three types of exceptions in Erlang: exit, throw, and error.
% 1. Exit: This type of exception is used to indicate that a process has terminated.
% It can be triggered by calling the exit/1 function or by a process crashing.
% 2. Throw: This type of exception is used to indicate that a specific condition has occurred.
% It can be triggered by calling the throw/1 function.
% 3. Error: This type of exception is used to indicate that an error has occurred.
% It can be triggered by calling the error/1 function or by a runtime error.
% To handle exceptions in Erlang, you can use the try...catch construct.
% This allows you to catch specific exceptions and handle them accordingly.
% You can also use the after clause to specify code
% that should be executed regardless of whether an exception occurred or not.
% Here is an example of how to use try...catch to handle exceptions in Erlang:
% try
%     % Code that may raise an exception
% catch
%     % Handle specific exceptions
%     exit:Reason ->
%         io:format("Process exited with reason: ~p~n", [Reason]);
%     throw:Value ->
%         io:format("Caught a throw with value: ~p~n", [Value]);
%     error:Error ->
%         io:format("An error occurred: ~p~n", [Error])
% end.

% In this example, we are trying to execute some code that may raise an exception. If an exit exception occurs, we catch it and print the reason. If a throw exception occurs,
% we catch it and print the value. If an error occurs, we catch it and print the error message. This allows us to handle exceptions gracefully and prevent crashes in our Erlang programs.

divide(X, Y) ->
    try
        X / Y
    catch
        error:badarith ->
            io:format("Cannot divide by zero~n"),
            undefined
    end.

errors(F) ->
    try F() of
        _ -> ok
    catch
        error:Error -> {error, caught, Error}
    end.
exits(F) ->
    try F() of
        _ -> ok
    catch
        exit:Exit -> {exit, caught, Exit}
    end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) when is_function(Attack, 0) ->
    try Attack() of
        _ -> "None shall pass."
    catch
        throw:slice -> "It is but a scratch.";
        error:cut_arm -> "I've had worse.";
        exit:cut_leg -> "Come on you pansy!";
        _:_ -> "Just a flesh wound."
    end.
