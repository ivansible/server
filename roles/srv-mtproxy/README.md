# ivansible.lin-mtproxy
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

- `mtproxy_rmdocker`
- `mtproxy_install`
- `mtproxy_service`
- `mtproxy_firewall`


## Dependencies

docker (optional)


## Example Playbook

    - hosts: vag1
      roles:
         - role: ivansible.lin-mtproxy
           mtproxy_port: 13128


## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
