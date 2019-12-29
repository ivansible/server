# srv_postgres

This role installs postgresql-10 server on linux and also:
 - tunes kernel parameters for postgresql performance;
 - enables ssl;
 - configures timezone and locale;
 - enables passwordless access from trusted networks;
 - tweaks other postgresql server parameters;


## Requirements

None


## Variables

Available variables are listed below.

---
    srv_pg_release: 10

    srv_pg_service: derived from _srv_pg_release_
    srv_pg_conf_dir: derived from _srv_pg_release_

    srv_pg_host: localhost
    srv_pg_port: 5432

    srv_pg_admin_password: pg_secret

    srv_pg_ssl_cert: /etc/ssl/certs/ssl-cert-snakeoil.pem
    srv_pg_ssl_key: /etc/ssl/private/ssl-cert-snakeoil.key
Pair of certificate/private key files for SSL access.
By default this is inherited from a nginx certificate defined by the role
[ivansible.nginx_base](https://github.com/ivansible/nginx-base#variables)
that in turn defaults to a so-called _snakoil_ certificate,
which is generated on fly by the `ssl-cert` Ubuntu package.

    srv_pg_local_subnets: []
List of IP networks formatted like `192.168.0.0/16` .
Client logins from these networks will not require a password.

    srv_pg_timezone: UTC
    srv_pg_locale: en_US.UTF-8
Timezone and locale names.

    srv_pg_parameters:
      ...
A dictionary of parameters.
The default parameters are optimized for a small postgresql instance
on a 1GB VPS box for at most 100 simultaneous client connections.

    srv_pg_kernel_params:
      kernel.msgmnb kernel.msgmax kernel.shmmax
A dictionary of tunable kernel parameters.
The default `shmmax` is set to 512mb which is 50% of 1GB VPS RAM/
I suspect that too big `shmmax` can crash system.


## Tags

- `srv_postgres_install` -- install postgresql server package
- `srv_postgres_sysctl` -- tune kernel parameters for postgresql performance
- `srv_postgres_ssl` -- grant postgres access to ssl certificates
- `srv_postgres_config` -- configure postgres parameters and authentication
- `srv_postgres_service` -- enable/restart postgres service, set admin password
- `srv_postgres_firewall` -- open postgres port in linux firewall


## Dependencies

- [ivansible.nginx_base](https://github.com/ivansible/nginx-base#variables)
  -- for file path to default ssl certificate
  -- for common defaults, handlers and custom modules


## TODO
Maybe use OOM killer to tame Postgres children footprint.
See: http://unix.stackexchange.com/questions/220362/systemd-postgresql-start-script


## Example Playbook

    - hosts: database-host
      roles:
         - role: ivansible.srv_postgres
           srv_pg_timezone: W-SU


## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
