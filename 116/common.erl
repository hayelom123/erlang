-module(common).

-export([first_robot/0, create_robot/0, main/1]).
% -compile(export_all).

-record(robot, {
    name,
    type = industial,
    hobbies,
    details = []
}).
% create() -> create("Mechtron", "R2D2", ["beeping", "whistling"]).
first_robot() ->
    #robot{
        name = "Mechatron",
        type = handmade,
        details = ["Moved by a small man inside"]
    }.
main(Args) ->
    io:format("Args: ~p\n", [Args]).
create_robot() ->
    Robot = first_robot(),
    io:format("Robot: ~p\n", [Robot]).
