compile:
	@rebar compile

dev:
	erl -pa ./ebin -eval "application:start('erlbot')" -noshell

run: dev

prod:
	@erl -pa ./ebin -eval "application:start('erlbot')" \
	-name erlbot@$${HOSTNAME} -setcookie `cat ~/.erlang.cookie` \
	-noshell -detached

daemon: prod

stop:
	@erl -pa ./ebin -eval "rpc:call('erlbot@$${HOSTNAME}', init, stop, [])" \
	-name controller@$${HOSTNAME} -setcookie `cat ~/.erlang.cookie` \
	-noshell -s erlang halt
