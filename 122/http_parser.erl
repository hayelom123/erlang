-module(http_parser).
-export([parse/1]).

%% =========================
%% ENTRY
%% =========================
parse(Raw) when is_binary(Raw) ->
    parse(binary_to_list(Raw));
parse(Request) when is_list(Request) ->
    {Head, _Body} = split_head_body(Request),

    [RequestLine | HeaderLines] =
        string:split(Head, "\r\n", all),

    {Method, Path, Version} = parse_request_line(RequestLine),

    Headers = parse_headers(HeaderLines, #{}),

    #{
        method => Method,
        path => Path,
        version => Version,
        headers => Headers
    }.

%% =========================
%% SPLIT HEAD / BODY
%% =========================
split_head_body(Request) ->
    case string:split(Request, "\r\n\r\n", all) of
        [Head, Body] -> {Head, Body};
        [Head] -> {Head, ""}
    end.

%% =========================
%% REQUEST LINE
%% =========================
parse_request_line(Line) ->
    case string:tokens(Line, " ") of
        [Method, Path, Version] ->
            {Method, Path, Version};
        _ ->
            {"UNKNOWN", "/", "HTTP/1.1"}
    end.

%% =========================
%% HEADERS
%% =========================
parse_headers([], Acc) ->
    Acc;
parse_headers(["" | _], Acc) ->
    Acc;
parse_headers([Line | Rest], Acc) ->
    Clean = string:trim(Line),

    case string:split(Clean, ":", leading) of
        [Key, Value] ->
            parse_headers(
                Rest,
                maps:put(
                    normalize(Key),
                    string:trim(Value),
                    Acc
                )
            );
        _ ->
            parse_headers(Rest, Acc)
    end.

%% =========================
%% NORMALIZE KEY
%% =========================
normalize(Key) ->
    string:lowercase(string:trim(Key)).
