server {
  server_name example.com;
  listen 80;
  root /home/examplecom/www/public_html;
  access_log /home/examplecom/www/logs/access.log;
  error_log /home/examplecom/www/logs/error.log;
  auth_basic "Authentication";
  auth_basic_user_file /home/examplecom/www/.htpasswd;
  index index.php index.html index.htm;

  location / {
    try_files $uri $uri/ /index.php?$args;
  }

  location ~ \.php$ {
    try_files $uri =404;
    fastcgi_pass unix:/var/run/phpfpm.example.com.sock;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_script_name;
  }

  location ~ /\.ht {
    deny all;
  }
}
