-module(records).
-export([
    new/2,
    change_name/2,
    car/0,
    create_connection/3,
    get_connection_state/1,
    get_connection_ip/1,
    get_connection_port/1
]).

% records are a way to define a structured data type with named fields.
% They are similar to structs in C or classes in object-oriented languages,
% but they are immutable and do not have methods.
% Records are defined using the -record directive,
% which takes the name of the record and a list of field names.
-record(person, {name, age}).
-record(car, {make = "unknown", model = "unknown", year = 0}).
-record(connection, {
    socket,
    ip,
    port,
    state = connected
}).

new(Name, Age) ->
    #person{name = Name, age = Age}.

change_name(Person, NewName) ->
    Person#person{name = NewName}.

car() ->
    #car{}.
create_connection(Socket, IP, Port) ->
    #connection{socket = Socket, ip = IP, port = Port}.
get_connection_state(Connection) ->
    Connection#connection.state.
get_connection_ip(Connection) ->
    Connection#connection.ip.
get_connection_port(Connection) ->
    Connection#connection.port.
