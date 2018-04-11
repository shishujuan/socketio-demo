#!/bin/sh
shut_down(){
    /etc/init.d/nginx stop
    /etc/init.d/uwsgi stop
    pkill -P 1
    exit
}
trap "shut_down" TERM

#start nginx
/etc/init.d/nginx start

#start uwsgi
mkdir -p /var/run/uwsgi && chown -R nobody:nogroup /var/run/uwsgi
/etc/init.d/uwsgi start

sleep infinity & wait
