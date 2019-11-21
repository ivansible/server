# ivansible.lin_dante_auth

This role installs dante proxy server on linux and configures authentication and IPv6 support (see https://www.inet.no/dante/doc/1.4.x/config/ipv6.html).


## Requirements

Dante supports authentication starting from version `1.4.1` only.
On _ubuntu 18.04 bionic_, the [dante-server](https://packages.ubuntu.com/bionic/dante-server) universe package is used.
On _ubuntu 16.04 xenial_, the [bionic .deb file](https://lug.mtu.edu/ubuntu/pool/universe/d/dante/dante-server_1.4.2+dfsg-2build1_amd64.deb) is installed, since official package is old _1.1.9_.


## Variables

Available variables are listed below, along with default values.

    dante_port: 1080
    dante_direct: yes
If direct is true, the port will be enabled in ubuntu firewall.
If not, you should configure another service to enable indirect access to this port.

    dante_user: dante_socks
Note: dante username must start with 'dante_' because it's a global linux user

    dante_pass: secret
    dante_salt: `random_string`

## Tags

- `lin_dante_user`
- `lin_dante_conf`
- `lin_dante_install`
- `lin_dante_service`
- `lin_dante_firewall`
- `lin_dante_all`


## Dependencies

None


## Example Playbook

    - hosts: vag1
      roles:
         - role: ivansible.lin_dante_auth
           dante_port: 3128


## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
