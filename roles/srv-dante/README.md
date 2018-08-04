# ivansible.lin-dante-auth
This role installs dante proxy server on linux and configures authentication.


## Requirements

Dante supports authentication starting from version `1.4.1` only.
On _ubuntu 18.04 bionic_, the [dante-server](https://packages.ubuntu.com/bionic/dante-server) universe package is used.
On _ubuntu 16.04 xenial_, the [bionic .deb file](https://lug.mtu.edu/ubuntu/pool/universe/d/dante/dante-server_1.4.2+dfsg-2build1_amd64.deb) is installed, since official package is old _1.1.9_.


## Variables

Available variables are listed below, along with default values.

    dante_port: 1080
    dante_user: socks5
    dante_pass: secret
    dante_salt: `random_string`


## Tags

- `dante_user`
- `dante_conf`
- `dante_install`
- `dante_service`
- `dante_firewall`


## Dependencies

None


## Example Playbook

    - hosts: vag1
      roles:
         - role: ivansible.lin-dante-auth
           dante_port: 3128


## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
