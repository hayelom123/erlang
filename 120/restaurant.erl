%% restaurant.erl
%%
%% A small real example showing:
%% - link
%% - trap_exit
%% - monitor
%% - register
%% - restart (supervisor idea)
%% - possible failures and handling

-module(restaurant).

-export([
    start/0,
    manager/0,
    cook/0,
    customer/0
]).

%% ========================================
%% START SYSTEM
%% ========================================

start() ->
    %% Start manager first
    spawn(fun manager/0),

    %% Customer watches manager safely
    spawn(fun customer/0).

%% ========================================
%% MANAGER (mini supervisor)
%% ========================================

manager() ->
    %% Important:
    %% don't die when linked process dies
    process_flag(trap_exit, true),

    io:format("Manager started~n"),

    %% Start cook and LINK to it
    CookPid = spawn_link(fun cook/0),

    %% Give cook a permanent name
    register(cook, CookPid),

    io:format("Cook started with pid ~p~n", [CookPid]),

    manager_loop(CookPid).

manager_loop(CookPid) ->
    receive
        %% =========================
        %% Normal order
        %% =========================
        order_food ->
            cook ! make_food,
            manager_loop(CookPid);
        %% =========================
        %% Force cook to crash
        %% =========================
        crash_cook ->
            io:format("Manager: crashing cook intentionally...~n"),
            exit(CookPid, kitchen_fire),
            manager_loop(CookPid);
        %% =========================
        %% Linked process died
        %% because trap_exit = true
        %% we receive message instead
        %% =========================
        {'EXIT', CookPid, Reason} ->
            io:format(
                "Manager noticed cook crashed: ~p~n",
                [Reason]
            ),

            %% unregister old dead process
            unregister(cook),

            %% restart cook
            NewCookPid = spawn_link(fun cook/0),
            register(cook, NewCookPid),

            io:format(
                "Manager restarted cook: ~p~n",
                [NewCookPid]
            ),

            manager_loop(NewCookPid);
        %% =========================
        %% Unknown message
        %% =========================
        Other ->
            io:format(
                "Manager got unknown message: ~p~n",
                [Other]
            ),
            manager_loop(CookPid)
    end.

%% ========================================
%% COOK (worker process)
%% ========================================

cook() ->
    receive
        %% Normal work
        make_food ->
            io:format("Cook: preparing food~n"),
            cook();
        %% Simulated failure
        burn_food ->
            io:format("Cook burned the food!~n"),
            exit(food_burned);
        %% Another crash example
        kitchen_fire ->
            io:format("Cook: kitchen on fire!~n"),
            exit(kitchen_fire);
        %% Unknown message
        Other ->
            io:format(
                "Cook received strange message: ~p~n",
                [Other]
            ),
            cook()
    end.

%% ========================================
%% CUSTOMER (monitor example)
%% ========================================

customer() ->
    timer:sleep(1000),

    %% Find manager pid
    ManagerPid = whereis(init),

    %% safer example would be real pid
    %% here just demonstrating monitor

    Ref = erlang:monitor(process, ManagerPid),

    io:format("Customer is watching manager~n"),

    receive
        {'DOWN', Ref, process, ManagerPid, Reason} ->
            io:format(
                "Customer noticed manager died: ~p~n",
                [Reason]
            )
    after 5000 ->
        io:format(
            "Customer: manager still alive, all good~n"
        )
    end.
