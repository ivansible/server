# ivansible.lin_mtproxy

This role installs [mtg mtproto proxy](https://github.com/9seconds/mtg) on linux


## Requirements

None


## Variables

Available variables are listed below, along with default values.

    mtproxy_port: 13128
    mtproxy_bindip: 0.0.0.0
    mtproxy_secret: cf18fa8ea0267057e2c61a5f7322a8e7
    mtproxy_secure: yes
    mtproxy_release: latest

    mtproxy_rmdocker: no
    mtproxy_reinstall: no
    mtproxy_bin_file: /usr/local/sbin/mtg


## Tags

- `lin_mtproxy_rmdocker`
- `lin_mtproxy_install`
- `lin_mtproxy_service`
- `lin_mtproxy_firewall`
- `lin_mtproxy_all`


## Dependencies

docker (optional)


## Example Playbook

    - hosts: myproxy
      roles:
         - role: ivansible.lin_mtproxy
           mtproxy_port: 13128


## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
