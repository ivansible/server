# ivansible.srv_redis

This role installs redis server on a linux host and enables SSL access for redis
by running a stunnel service in front.

Redis systemd service is named `redis-server` and stunnel service providing
SSL access to redis is named `redis-stunnel`.


## Requirements

None


## Variables

Available variables are listed below, along with default values.

    redis_port_tcp: 6379
    redis_port_ssl: 7379
Ports where redis and stunel services listen. This role configures
redis and stunnel to listen on all IPv4 / IPv6 host addresses. 

    redis_open_ports:
      #- "{{ redis_port_tcp }}"
      - "{{ redis_port_ssl }}"
By default only SSL port is accessible from outside, while TCP port
is accessible only locally on the redis host.

    redis_password: please_change
If this parameter is unset or set to an empty string, password authentication
will be disabled.

    redis_ssl_cert: "{{ nginx_ssl_cert }}"
    redis_ssl_key: "{{ nginx_ssl_key }}"
The stunnel service will run as user `nobody` for better security and as group
required for read access to SSL private key (`ssl-group` or certbot group).

    redis_databases: 16
Number of redis databases to serve.

    redis_parameters:
      bind: "0.0.0.0 ::"     # listen on all interfaces
      port: "{{ redis_port_tcp }}"
      databases: "{{ redis_databases }}"
      dir: /var/lib/redis    # default from package
      dbfilename: dump.rdb   # default from package
This will not need to tweak this dictionary for a standard install.


## Tags

- `srv_redis_all` -- all actions


## Dependencies

Default certificate and private key are inherited from `ivansible.nginx_base`.


## Example Playbook

    - hosts: db-host
      roles:
         - role: ivansible.srv_redis
           redis_password: supersecret


## License

MIT

## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)
