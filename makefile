# makefile: build and deploy from source/ to web/, start/stop the server.
# Copyright (c) 2011 Jan Keromnes & Yann Tyl. No rights reserved.

SERVER = server.js
SOURCE = source
TARGET = web
MIN = min

build : clean deploy minify

clean :
	rm -rf web/*

deploy :
	cp -r $(SOURCE)/* $(TARGET)
	
minify :
	for file in `find web -name '*\.js'` ; do cat "$${file}" | jsmin > "$${file}$(MIN)" ; mv "$${file}$(MIN)" "$${file}" ; done

test :
	cd $(SOURCE) ; sudo node ../$(SERVER)

start :
	cd $(TARGET) ; sudo nohup node ../$(SERVER) > ../node.log &

stop :
	for pid in `ps aux | grep node | grep $(SERVER) | awk '{print $$2}'` ; do sudo kill $$pid 2> /dev/null ; done

# time for a break
coffee :
	@echo "\n           )      (\n           (  )   )\n         _..,-(--,.._\n      .-;'-.,____,.-';\n     (( |            |\n      \`-;            ;\n         \\          /	\n      .-''\`-.____.-'''-.\n     (     '------'     )\n      \`--..________..--'\n";

# http://xkcd.com/149/
sandwich :
	@if [ `id -u` = "0" ] ; then echo "\nOKAY." ; else echo "\nWhat? Make it yourself." ; fi
	
