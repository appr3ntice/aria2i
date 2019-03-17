#!/bin/sh

nginx
touch /home/aria2/Downloads/.aria2.session
aria2c --rpc-secret=${RPC_SECRET}
