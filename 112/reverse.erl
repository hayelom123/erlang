-module(reverse).
-export([reverse/1, ef_reverse/1, sublist/2, ef_sublist/2]).

reverse([]) -> [];
reverse([H | T]) -> reverse(T) ++ [H].

% The reverse function takes a list as input and returns a new list with the elements in reverse order.
% The function uses recursion to reverse the list. The base case is when the input list is empty, in which case it returns an empty list. For non-empty lists, the function takes the head of the list (H) and appends it to the reversed tail of the list (reverse
% (T)). The ++ operator is used to concatenate the reversed tail with the head, effectively building the reversed list as the recursion unwinds.
% Note that this implementation is not the most efficient way to reverse a list in Erlang, as it has a time complexity of O(n^2) due to the use of the ++ operator. A more efficient implementation would use an accumulator to avoid the need for concatenation, resulting in a time complexity of O(n).

% Here is an example of a more efficient implementation of the reverse function using an accumulator:
ef_reverse(List) -> ef_reverse(List, []).
ef_reverse([], Acc) -> Acc;
ef_reverse([H | T], Acc) -> ef_reverse(T, [H | Acc]).

sublist(_, 0) -> [];
sublist([], _) -> [];
sublist([H | T], N) -> [H | sublist(T, N - 1)].

% [1,2,3,4]. -> [1,2,3]

% let's make it efficient by using an accumulator

ef_sublist(L, N) -> ef_sublist(L, N, []).
ef_sublist(_, 0, Acc) -> Acc;
ef_sublist([], _, Acc) -> Acc;
ef_sublist([H | T], N, Acc) -> ef_sublist(T, N - 1, [H | Acc]).
