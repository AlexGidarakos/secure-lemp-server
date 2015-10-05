[example.com]
listen = /var/run/phpfpm.example.com.sock
listen.owner = www-data
listen.mode = 0660
user = examplecom
group = examplecom
pm = static
pm.max_children = 2
pm.max_requests = 50
chdir = /
