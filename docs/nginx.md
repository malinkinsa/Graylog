# Nginx

## graylog.example.com.conf
```
server {
  listen 80;
  listen 443 ssl http2;
  server_name graylog.example.com;

  ssl_certificate      /etc/nginx/certs/tls.crt;
  ssl_certificate_key  /etc/nginx/certs/tls.key;

  access_log /var/log/nginx/graylog-access.log;
  error_log /var/log/nginx/graylog-error.log;

  if ($scheme = http) {
    return 301 https://$server_name$request_uri;
  }

  location / {
      proxy_set_header Host $http_host;
      proxy_set_header X-Forwarded-Host $host;
      proxy_set_header X-Forwarded-Server $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Graylog-Server-URL https://$server_name/;

      proxy_pass http://your_ip:9000/;

  }
}
```