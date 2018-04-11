FROM debian:8.8

ENV configdir=config srcdir=src

COPY ${configdir}/timezone/localtime /etc/localtime
COPY ${configdir}/apt/sources.list /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y build-essential python-pip pkg-config curl vim tree psmisc nginx libssl-dev python-dev

RUN mkdir -p /home/project/socketio-demo /home/env /home/entrypoint
RUN UWSGI_PROFILE_OVERRIDE=ssl=true pip install uwsgi -Iv
COPY ${configdir}/requirements.txt /home/env/
RUN pip install -r /home/env/requirements.txt

RUN apt-get install -y tcpdump
COPY ${srcdir}/entrypoint.sh /home/entrypoint/entrypoint.sh
COPY ${srcdir}/uwsgi /etc/init.d/uwsgi
COPY ${configdir}/uwsgi/ /etc/uwsgi/

COPY ${configdir}/nginx/ /etc/nginx/
COPY ${srcdir}/socketio-demo/ /home/project/socketio-demo/

RUN chmod u+x /home/entrypoint/entrypoint.sh \
    && chmod u+x /etc/init.d/uwsgi \
    && chown -R nobody:nogroup /home/project \
    && chown -R nobody:nogroup /home/env \
    && chown nobody:nogroup -R /etc/uwsgi

ENTRYPOINT ["/home/entrypoint/entrypoint.sh"]
