-module(math).
-export([factorial/1, mult/2]).

factorial(1) ->
    1;
factorial(N) ->
    N * factorial(N - 1).

mult(A, B) -> A * B.
