# ivansible.lin_tor

This role installs tor daemon with privoxy forwarding on Linux.


## Requirements

None


## Variables

    tor_socks_port: 9050

    tor_privoxy_enable: true
    tor_privoxy_bindip: 127.0.0.1
    tor_privoxy_port: 8118


## Tags

- `lin_tor_install` -- install tor package
- `lin_tor_service` -- activate tor daemon
- `lin_tor_config`  -- configure tor socks port and exit nodes
- `lin_tor_privoxy` -- configure local privoxy forwarding
- `lin_tor_all` -- all of the above


## Dependencies

None


## Example Playbook

    - hosts: vagrant1
      roles:
         - role: ivansible.lin_tor
           tor_privoxy_port: 9058


## License

MIT

## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)
