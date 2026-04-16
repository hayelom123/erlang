-module(strings).

-export([string/0, multiline_string/0]).

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
