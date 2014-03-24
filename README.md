# erlbot


## Introduction

Like other IRC bots, this erlbot is an irc bot I wrote to help me learn Erlang.
The plugin system makes it easy to add functionality.

Out of the box it is configured to connect to localhost:6667 and join #erlang
and #bots. Copy ``./user_conf/user.conf.erl.sample`` to
``./user_conf/user.conf.erl`` and customize.

Author: dev@wolfplusplus.com


## Running

If you'd like to run erl bot in dev mode (running in the foreground, logging
everything to ``stdout``), do the following (you'll need to compile first):
```bash
    $ make compile
    $ make dev
```
or
```bash
    $ made run
```

If you'd like to daemonize the process:
```bash
    $ make prod
```
or
```bash
    $ make daemon
```


## Stopping

If you're running in the foregrund, ``^C^C`` will bring you back to the OS
shell.

If you're running in daemonized mode:

```bash
    $ make stop
```


## Supervision Tree

```
erlbot_app+->erlbot_sup+->+--+irc_router
                          |
                          +--+plugin_sup+->+-+ping_plugin
                          |                |
                          +--+bot_conn     +-+nick_plugin
                                           |
                                           +-+channel_plugin
                                           |
                                           +-+evangelize_plugin
```


## Design Notes

* ``bot_conn`` - Manages the socket connection.
* ``irc_router`` - Event manager which parses incoming irc messages and notifies
  subscribers with easy to filter events
* ``plugin_sup`` - Plugin supervisor.  Define plugins to load in here.  You can add
  plugins and load them without restarting the bot.
