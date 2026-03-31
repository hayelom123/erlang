-module(parameter).

-export([greet/1]).
% variables must start with an uppercase letter or an underscore,
% and they are used to store values that can be changed during the execution of a program.
% In this example, we have a function called 'greet' that takes one parameter, 'Name', which is expected to be a string.
% The function uses the 'io:format' function to print a greeting message that includes the value of 'Name'.
% The '~s' in the format string is a placeholder for a string value,
% and '[Name]' is the list of arguments that will replace the placeholders in the format string when it is executed.
greet(Name) ->
    io:format("Hello, ~s!~n", [Name]).
