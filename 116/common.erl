-module(common).

-export([
    first_robot/0,
    create_robot/0,
    main/1,
    send_message/3,
    admin_panel/1,
    adult_section/1,
    driving_license/1
]).
% -compile(export_all).

-record(robot, {
    name,
    type = industial,
    hobbies,
    details = []
}).
-record(message, {sender, receiver, content}).
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

send_message(Sender, Receiver, Content) ->
    Message = #message{sender = Sender, receiver = Receiver, content = Content},
    io:format("Message sent: ~p\n", [Message]),
    #message{sender = Sender, receiver = Receiver, content = Content} = Message,
    #message{receiver = Receiver1} = Message,
    io:format("Message details - Sender: ~p, Receiver: ~p, Content: ~p\n", [
        Sender, Receiver, Content
    ]),
    Sender1 = Message#message.sender,
    io:format("Message details using pattern matching - Sender: ~p\n", [Sender1]),
    io:format("Message details using pattern matching - Receiver: ~p\n", [Receiver1]).

-record(user, {name, group, age}).
% use pattern matching for fileter

admin_panel(#user{name = Name, group = admin}) ->
    io:format("Welcome, Admin ~p! You have full access to the system.~n", [Name]);
admin_panel(#user{name = Name}) ->
    io:format("~p is not an admin. Access denied.", [Name]).

adult_section(U = #user{}) when U#user.age >= 18 ->
    io:format("Welcome, ~p! You have access to the adult section.~n", [U#user.name]);
adult_section(#user{name = Name}) ->
    io:format("Sorry, ~p. You must be at least 18 years old to access the adult section.", [Name]).

driving_license(#user{name = Name, age = Age}) when Age >= 16 ->
    % Debugging line to check the age value default is undefined
    io:format("Age: ~p\n", [Age]),
    io:format("Congratulations, ~p! You are eligible for a driving license.~n", [Name]);
driving_license(#user{name = Name}) ->
    io:format("Sorry, ~p. You must be at least 16 years old to get a driving license.", [Name]).
