FROM nginx:1.11-alpine

RUN apk update && apk add curl bind-tools

# install confd
RUN cd /usr/local/bin ; curl -s -L https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 -o confd ; chmod +x confd && \
mkdir -p /etc/confd/templates ; mkdir -p /etc/confd/conf.d

# nginx config file with nginx in foreground
COPY nginx.conf /etc/nginx/nginx.conf

# nginx .conf template files
COPY *.tmpl /etc/confd/templates/
# corresponding toml files
COPY *.toml /etc/confd/conf.d/

COPY confd-watch.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/confd-watch.sh && rm /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD /usr/local/bin/confd-watch.sh
