######
erlbot
######


Introduction
============

Like other IRC bots, this erlbot is an irc bot I wrote to help me learn Erlang.
The plugin system makes it easy to add functionality.

Out of the box it is configured to connect to localhost:6667 and join #erlang
and #bots. Copy ``./user_conf/user.conf.erl.sample`` to
``./user_conf/user.conf.erl`` and customize.

Author: dev@wolfplusplus.com


Running
=======

```bash
    $ ./rebar compile
    $ erl -pa ./ebin -eval "application:start('erlbot')" -noshell
```

That will run erlbot in the foreground. If you'd like to daemonize the process:

```bash
    $ erl -pa ./ebin -eval "application:start('erlbot')" \
      -name erlbot@${HOSTNAME} -setcookie abc123 -noshell -detached
```


Stopping
========

If you're running in the foregrund, ``^C^C`` will bring you back to the OS
shell.

If you're running in daemonized mode:

```bash
    $ erl -pa ./ebin -eval "rpc:call('erlbot@${HOSTNAME}', init, stop, [])" \
      -name controller@${HOSTNAME} -setcookie abc123 -noshell -s erlang halt
```

application:stop(erlbot).


Supervision Tree
================

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


Design Notes
============

* ``bot_conn`` - Manages the socket connection.
* ``irc_router`` - Event manager which parses incoming irc messages and notifies
  subscribers with easy to filter events
* ``plugin_sup`` - Plugin supervisor.  Define plugins to load in here.  You can add
  plugins and load them without restarting the bot.
