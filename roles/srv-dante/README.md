# ivansible.lin-dante-auth
This role installs dante proxy server on linux and configures authentication.


## Requirements

Dante supports authentication starting from version `1.4.1`.
The default universe package is used on _ubuntu 18.04 bionic_.
On _xenial_, the bionic _.deb_ package is installed.


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
