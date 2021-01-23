# BASE
FROM alpine
# RUN
RUN apk add nginx; \
    apk add vim; \
    apk add curl; \
    mkdir /run/nginx/; 
# CONFIGUTATIONS
# nginx configuration
ADD $PWD/config/default.conf /etc/nginx/conf.d/default.conf
ADD $PWD/config/proxy_params /etc/nginx/proxy_params
# keys and certs
ADD $PWD/config/*.key /etc/ssl/private/
ADD $PWD/config/*.crt /etc/ssl/certs/
WORKDIR /var/www/localhost/htdocs
# ENTRYPOINT
COPY $PWD/config/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]
# EXPOSE PORTS
EXPOSE 80
EXPOSE 443
# RUN COMMAND
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]
