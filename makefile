# Makefile: Build and deploy from source/ to web/, start/stop the server.
# Copyright (c) Jan Keromnes 2011. No rights reserved.

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
	for file in `find $(TARGET) -name '*\.js'` ; do cat $$file | jsmin > $$file$(MIN) ; mv $$file$(MIN) $$file ; done

test :
	cd $(TARGET) ; sudo node ../$(SERVER)
	
restart : stop start
	
start :
	cd $(TARGET) ; sudo nohup node ../$(SERVER) > ../node.log &
	
stop :
	for pid in `ps aux | grep node | grep $(SERVER) | awk '{print $$2}'` ; do sudo kill $$pid 2> /dev/null ; done

# BONUS

coffee :
	echo "\n\n           )      (\n           (  )   )\n         _..,-(--,.._\n      .-;'-.,____,.-';\n     (( |            |\n      \`-;            ;\n         \\          /	\n      .-''\`-.____.-'''-.\n     (     '------'     )\n      \`--..________..--'\n";
	
sandwich :
	if [ `id -u` = "0" ] ; then echo "\nOkay." ; else echo "\nWhat? Make it yourself." ; fi
	
