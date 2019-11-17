# ivansible.srv_mongodb

This role installs mongodb-org 4.0.x server and client on a linux host and:
- enables SSL, optionally configuring letsencrypt post-renewal hook;
- resets administrator password
- optionally sets systemd cpu and memory quotas.


## Requirements

None


## Variables

Available variables are listed below, along with default values.

    mongodb_port: 27017
Change this to have mongodb server listen on non-standard port.
This role configures mongodb to listen on all IPV4 and IPV6 addresses.

    mongodb_admin_username: admin
    mongodb_admin_password: please_change
This role will set mongodb administrator password accordingly.

    mongodb_ssl_mode: preferSSL
Can be `preferSSL` or `requireSSL` or `allowSSL`.
By default this option is set to `preferSSL` because some clients
do not support SSL, e.g. Robomongo 0.9rc.

    mongodb_ssl_cert: "{{ nginx_ssl_cert }}"
    mongodb_ssl_key: "{{ nginx_ssl_key }}"
Path to PEM-encoded SSL certificate and private key files.

    mongodb_cpu_quota: unlimited
CPU quota can be `unlimited` (or empty string) or percentage e.g. `50%`.
Setting this value too small can result in longer mongodb startup time,
or even playbook failure due to timeout.
See [Systemd resource control and CPU shares (freedesktop)](https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html#CPUShares=weight)

    mongodb_mem_quota: unlimited
Memory quota can be `unlimited` (or empty string) or a numeric value in
megabytes with suffix `M`, e.g. `512M`. It limits **physical** memory (RSS).
If exceeded, forces swapout.

    mongodb_oom_killer: no
This `yes` / `no` option activates OOM killer when memory quota is exceeded.
See:
- [Systemd Memory Limit (freesktop)](https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html#MemoryLimit=bytes)
- [Systemd OOMScoreAdjust (freedesktop)](https://www.freedesktop.org/software/systemd/man/systemd.exec.html#OOMScoreAdjust=)
- [How to set OOM killer adjustments (stackexchange)](http://unix.stackexchange.com/questions/58872/how-to-set-oom-killer-adjustments-for-daemons-permanently)
- [Taming the OOM killer](https://lwn.net/Articles/317814)
- [About cgroups](https://habrahabr.ru/company/selectel/blog/303190)


## Tags

- `srv_mongodb_all` -- all actions
- `srv_mongodb_install` -- install mongodb server and client packages,
                           and ansible python bindings
- `srv_mongodb_service` -- set systemd cpu and memory quotas for mongod service,
                           open mongodb port in ubuntu firewall
- `srv_mongodb_ssl` -- concatenate ssl certificate and private key into combined
                       mongod pem file, and optionally activate a letsencrypt
                       post-renewal hook script
                       `/etc/letsencrypt/renewal-hooks/post/mongodb`.
- `srv_mongodb_password` -- reset mongodb administrator password
                            (temporarily suspends authentication)


## Dependencies

This role inherits default certificate and private key files
from the role `ivansible.nginx_base`.


## Example Playbook

    - hosts: db-host
      roles:
         - role: ivansible.srv_mongodb
           mongodb_admin_username: admin
           mongodb_admin_password: secret6


## License

MIT

## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)
