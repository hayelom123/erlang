-module(list).
% Lists are ordered collections of values. They are defined using square brackets [].
% For example, [1, 2, 3] is a list with three elements.
% Lists can contain elements of different types, such as [1, "hello", 3.14].
% You can access elements of a list using the hd/1 and tl/1 functions.
% The hd/1 function returns the head (first element) of the list,
% while the tl/1 function returns the tail (all elements except the head) of the list.
% For example, hd([1, 2, 3]) will return 1, and tl([1, 2, 3]) will return [2, 3].
% You can also create new lists by concatenating existing lists using the ++ operator. For example, [1, 2] ++ [3, 4] will result in [1, 2, 3, 4].
% Lists are often used in pattern matching and recursion to process collections of data.
%  [First |TheRest] = [1,2,3,4,5].
% First will be 1 and TheRest will be [2,3,4,5].
% [E1, E2 | R] = [1,2,3,4,5,6,7].
% E1 will be 1, E2 will be 2 and R will be [3,4,5,6,7].
% [A, B | C] = [1, 2].
% A will be 1, B will be 2 and C will be [].
% [A, B | C] = [1].
% This will result in an error because there is only one element in the list, and we are trying to match it with two variables (A and B).
% [A, B | C] = [].
% This will also result in an error because there are no elements in the list, and we are trying to match it with two variables (A and B).

-export([len/1]).

len([]) -> 0;
len([_ | T]) -> 1 + len(T).
