-module(atoms).

% atoms are constants whose value is their own name.
% They are used to represent fixed values or identifiers in Erlang.
% Atoms are often used to represent states, options, or symbolic values in a program.

% let's create a function that converts meter into centimeter and inch.
-export([convert/2]).

convert(M, cm) -> M * 100;
convert(M, in) -> M * 39.37.
