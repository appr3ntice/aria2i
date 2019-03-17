#!/bin/bash
docker run -dit --name=aria2i --restart=unless-stopped -p 80:8080 -p 6800:6800 -v /home/apprentice/Downloads:/home/aria2/Downloads aria2i
