Compile with:

erlc chat_server.erl

This creates:

chat_server.beam

(.beam = compiled Erlang bytecode)

🚀 2. Run function directly from terminal

You can execute a function without interactive shell:

erl -noshell -s chat_server start -s init stop

Meaning:

-noshell → no interactive shell
-s chat_server start → call chat_server:start()
-s init stop → shutdown VM after execution

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

⚡ 6. Run in background like a real server

Example:

nohup erl -noshell -s app start > server.log 2>&1 &

Now your Erlang app behaves like Linux daemon/server.
