# ivansible.srv_ziproxy

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
Colon-separated `user:password` tuple. Leave empty for no authentication.


## Tags

- `srv_ziproxy_install`
- `srv_ziproxy_config`
- `srv_ziproxy_config`
- `srv_ziproxy_service`
- `srv_ziproxy_firewall`
- `srv_ziproxy_all`


## Dependencies

None


## Example Playbook

    - hosts: myproxy
      roles:
         - role: ivansible.srv_ziproxy
           ziproxy_port: 8086


## License

MIT

## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)
