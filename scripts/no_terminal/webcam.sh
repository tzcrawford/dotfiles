#!/bin/bash
#spawns mpv showing your webcam feed

var="$(echo -e "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12" | ~/scripts/dmenu.sh)"

mpv av://v4l2:/dev/video${var}
