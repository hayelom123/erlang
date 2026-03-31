-module(tuples).

% Tuples are fixed-size collections of values. They are defined using curly braces {}.
% For example, {1, 2, 3} is a tuple with three elements.
% Tuples are commonly used to group related data together.
% You can access elements of a tuple using the element/2 function, which takes the index (starting from 1) and the tuple as arguments.
% For example, element(2, {1, 2, 3}) will return 2.
% You can also create tuples with different types of data, such as {name, age}.
% Tuples are immutable, meaning that once they are created, their contents cannot be changed.
% However, you can create a new tuple by combining existing tuples or by using the tuple syntax.
% For example, you can create a new tuple by combining two existing tuples: {1, 2} ++ {3, 4} will result in {1, 2, 3, 4}.
% You can also create a new tuple by using the tuple syntax:
% NewTuple = {OldTuple, NewValue}.
% Tuples are often used in pattern matching and function arguments to group related data together.
-export([convert/1]).

convert({Value, inch}) ->
    {Value * 2.54, cm};
convert({Value, cm}) ->
    {Value / 2.54, inch}.
