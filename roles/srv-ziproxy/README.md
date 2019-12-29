# ivansible.lin_ziproxy

This role installs ziproxy on linux.


## Requirements

None


## Variables

Available variables are listed below, along with default values.

    ziproxy_port: 3168
Port

    ziproxy_direct: true
If true, ports will be open for all. If false, ports will be blocked
from external networks.

    ziproxy_userpass: ""
Colon-separated `user:password` pair. Leave empty for no authentication.


## Tags

- `lin_ziproxy_install`
- `lin_ziproxy_config`
- `lin_ziproxy_config`
- `lin_ziproxy_service`
- `lin_ziproxy_firewall`
- `lin_ziproxy_all`


## Dependencies

None


## Example Playbook

    - hosts: myproxy
      roles:
         - role: ivansible.lin_ziproxy
           ziproxy_port: 8086


## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
