-module(recursion).
-export([fact/1, len/1]).

% Recursion is a programming technique where a function calls itself in order to solve a problem.
% In Erlang, recursion is commonly used to iterate over lists, perform calculations, and solve problems that can be broken down into smaller subproblems.
% A recursive function typically has two main components: a base case that stops the recursion,
% and a recursive case that breaks the problem into smaller parts and calls itself with those parts.
% For example, the factorial function can be defined recursively as follows:
% fact(0) -> 1;
% fact(N) when N > 0 -> N * fact(N - 1).
% in erlang there are no loops, so recursion is often used to achieve similar results as loops in other programming languages.
% However, it is important to ensure that the base case is properly defined to avoid infinite recursion and potential stack overflow errors.

fact(0) ->
    1;
fact(N) when N > 0 ->
    N * fact(N - 1).
% length of a list using recursion
len([]) ->
    0;
len([_ | T]) ->
    1 + len(T).

% tail recursion is a special form of recursion where the recursive call is the last operation performed in the function.
% Tail recursion can be optimized by the compiler to avoid stack overflow errors and improve performance.   
