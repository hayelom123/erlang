compile

```
erl module.erl
```

run

```
erl -noshell -s module function -s init stop
```

Meaning:

-noshell → no interactive shell
-s chat_server start → call chat_server:start()
-s init stop → shutdown VM after execution

```
erlc chat_server.erl
erl -noshell -s chat_server start -s init stop
```
