-module(balance).

-export([calculate/0]).

sum([]) -> 0;
sum([H | T]) -> H + sum(T).
calculate() ->
    Order = [
        %1
        36600,
        %2
        18600,
        %3
        520000,
        %4
        37000,
        %5
        188000,
        %6
        18700,
        %7
        19000,
        %8
        57000,
        %9
        73000,
        %10
        60000,
        %11
        90000,
        %12
        19000,
        %13
        19000,
        %14
        76000,
        %15
        54900,
        %16
        36600,
        %17
        38000,
        %18
        19000,
        %19
        20000,
        %20
        36600,
        %21
        50000,
        %22
        17950,
        %23
        30000,
        %24
        250000,
        %25
        37000,
        %26
        18300,
        %27
        76000,
        %27
        10000,
        %29
        66500,
        %30
        18300,
        %31
        19000,
        %32
        19000,
        %33
        19000,
        %35
        57000,
        %36
        19000,
        %37
        57000,
        %38
        76000,
        %39
        40000,
        %40
        18300,
        %41
        18000,
        %42
        9150,
        %43
        28500,
        %44
        19000,
        %45
        19000,
        %46
        30000,
        %47
        19000,
        %48
        19000,
        %49
        19000,
        %50
        38000,
        %51
        9500,
        %52
        19000,
        %53
        110000,
        %54
        38000
    ],
    Deposit = [
        1052378,
        100000,
        240000,
        % 210000,
        1117640,
        19635,
        560000,
        420000
    ],
    Totalorder = sum(Order),
    TotalDeposit = sum(Deposit),
    io:format("=====================Bereket==========================~n", []),
    io:format("Total Order:~p~n", [Totalorder]),
    io:format("Total Deposit:~p~n", [TotalDeposit]),
    CurrentBalance = TotalDeposit - Totalorder,
    io:format("Current Balance:~p~n", [CurrentBalance]),
    io:format("~n~n", []),

    io:format("=========================Esayas===========================~n", []),
    EsuOrder = [
        % 1
        376000,
        % 2
        17500,
        % 3
        17500,
        % 4
        17300,
        % 5
        201250,
        % 6
        4000,
        % 7
        50000,
        % 8
        31500,
        % 9
        0,
        % 10
        8750,
        % 11
        26250,
        % 12
        8750,
        % 13
        22500,
        % 14
        50000
    ],
    EsuDeposit = [
        -82944,
        300000,
        242500
    ],
    TotalEsuOrder = sum(EsuOrder),
    TotalEsuDeposit = sum(EsuDeposit),
    io:format("Total Order:~p~n", [TotalEsuOrder]),
    io:format("Total Deposit:~p~n", [TotalEsuDeposit]),
    EsuCurrentBalance = TotalEsuDeposit - TotalEsuOrder,
    io:format("Current Balance:~p~n", [EsuCurrentBalance]).
