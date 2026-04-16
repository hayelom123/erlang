-module(strings).

-export([string/0, multiline_string/0, to_upper/1, to_lower/1, concat/2,substring/1, substring/2, substring/3]).

% simple string

string() ->
    Val = "This is a string",
    io:format("~p~n", [Val]),
    Val.

multiline_string() ->
    Val = """
   This is a multiline string
    that spans multiple lines
        and preserves the formatting    

""",
    io:format("~p~n", [Val]),
    "\n".


to_upper(Str)->
    lists:map(fun(X) when X >= $a, X =< $z -> X - 32; (X) -> X end, Str).

to_lower(Str)->
    lists:map(fun(X) when X >= $A, X =< $Z -> X + 32; (X) -> X end, Str).

concat(Str1, Str2) ->
    Str1 ++ Str2.

% substring/1, substring/2, substring/3 
% you can just use sublist/1, sublist/2, sublist/3 from lists module but we will create our own for demonstration
substring(Str) ->
    lists:sublist(Str,length(Str)).
substring(Str, Start) ->
    lists:sublist(Str, Start). 
substring(Str, Start , Length) ->
    lists:sublist(Str, Start, Length).
 

