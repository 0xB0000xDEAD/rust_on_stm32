#!/usr/bin/env bash  
mkdir -p /etc/udev/rules.d
cat << EOF >> /etc/udev/rules.d/99-docker-tty.rules
ACTION=="add", SUBSYSTEM=="tty", RUN+="/usr/local/bin/docker_tty.sh 'added' '%E{DEVNAME}' '%M' '%m'"
ACTION=="remove", SUBSYSTEM=="tty", RUN+="/usr/local/bin/docker_tty.sh 'removed' '%E{DEVNAME}' '%M' '%m'"
EOF