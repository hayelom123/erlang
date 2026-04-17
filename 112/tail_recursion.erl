-module(tail_recursion).
-export([fact/1, len/1]).

% Tail recursion is a special form of recursion where the recursive call is the last operation performed in the function.
% Tail recursion can be optimized by the compiler to avoid stack overflow errors and improve performance.
% For example, the factorial function can be defined using tail recursion as follows:
fact(0, Acc) ->
    Acc;
fact(N, Acc) when N > 0 -> fact(N - 1, N * Acc).
fact(N) -> fact(N, 1).
% In this implementation, the recursive call to fact is the last operation performed in the function, and the intermediate result is passed as an accumulator (Acc) to avoid the need for the function to
% wait for the result of the recursive call before it can return a value. This allows the compiler to optimize the tail recursion and avoid stack overflow errors for large input values.
% Another example of tail recursion is the length of a list:
len([], Acc) ->
    Acc;
len([_ | T], Acc) ->
    len(T, Acc + 1).
len(List) -> len(List, 0).
% In this implementation, the recursive call to len is the last operation performed in the function, and the intermediate result is passed as an accumulator (Acc) to avoid the need for the function to wait for the result of the recursive call before it can return a value. This allows the compiler to optimize the tail recursion and avoid stack overflow errors for large input lists
