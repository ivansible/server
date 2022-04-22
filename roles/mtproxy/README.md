# ivansible.srv_mtproxy

This role installs [mtg mtproto proxy](https://github.com/9seconds/mtg) on linux


## Requirements

None


## Variables

Available variables are listed below, along with default values.

    mtproxy_port: 13128
    mtproxy_bindip: 0.0.0.0
    mtproxy_secret: cf18fa8ea0267057e2c61a5f7322a8e7
    mtproxy_release: latest

    mtproxy_upgrade: false
    mtproxy_bin_file: /usr/local/sbin/mtg


    mtproxy_nginx_host: ~
    mtproxy_cname_host: ~
    mtproxy_cloudflare_email: ~
    mtproxy_cloudflare_token: ~


## Tags

- `srv_mtproxy_install`
- `srv_mtproxy_service`
- `srv_mtproxy_firewall`
- `srv_mtproxy_all`


## Dependencies

docker (optional)


## Example Playbook

    - hosts: myproxy
      roles:
         - role: ivansible.srv_mtproxy
           mtproxy_port: 13128


## License

MIT

## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)
