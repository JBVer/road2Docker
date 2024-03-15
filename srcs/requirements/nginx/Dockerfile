FROM alpine:3.15.6

RUN apk update && apk add nginx openssl
RUN openssl req -nodes -x509 -days 365 -new -keyout /etc/nginx/certificate.key -out /etc/nginx/certificate.crt -subj "/C=FR/ST=75/L=Paris/O=42/CN=jvermeer.42.fr"

#copies our nginx config file to target directory
COPY default.conf /etc/nginx/http.d/default.conf

# daemon off = nginx running in foreground (-g = specifies a directive to nginx)
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
