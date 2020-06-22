# ivansible.srv_dante

This role installs dante proxy server on linux, configures authentication and IPv6 support (see https://www.inet.no/dante/doc/1.4.x/config/ipv6.html).


## Requirements

Dante supports authentication starting from version `1.4.1` only.
On _ubuntu 18.04 bionic_ (and later), the [dante-server](https://packages.ubuntu.com/bionic/dante-server) universe package is used.
On _ubuntu 16.04 xenial_, the [bionic .deb file](https://lug.mtu.edu/ubuntu/pool/universe/d/dante/dante-server_1.4.2+dfsg-2build1_amd64.deb) is installed (through pain and workarounds), since official package is old _1.1.9_.


## Variables

Available variables are listed below, along with default values.

    dante_port: 1080
    dante_direct: true
If direct is true, the port will be enabled in ubuntu firewall.
If not, you should configure another service to enable indirect access to this port.

    dante_external_addr: ...
The address to be used for outgoing connections.
Can be set as either an IP address or an interface name.
By default this is `ansible_default_ipv4.address`, but you can
set it as `ansible_default_ipv4.interface` (eg. `eth0`) or whatever you like.

    dante_user: dante_socks
Note: dante username must start with 'dante_' because it's a global linux user

    dante_pass: secret
    dante_salt: `random_string`
Password and salt.

    dante_verbose_log: false
Enables verbose logging (see https://www.inet.no/dante/doc/1.4.x/config/logging.html).


## Tags

- `srv_dante_user`
- `srv_dante_conf`
- `srv_dante_install`
- `srv_dante_service`
- `srv_dante_firewall`
- `srv_dante_syslog`
- `srv_dante_all`


## Dependencies

None


## Example Playbook

    - hosts: vag1
      roles:
         - role: ivansible.srv_dante
           dante_port: 3128


## License

MIT

## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)
