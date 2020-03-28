# ivansible.srv_sshtun

[![Github Test Status](https://github.com/ivansible/srv-sshtun/workflows/Molecule%20test/badge.svg?branch=master)](https://github.com/ivansible/srv-sshtun/actions)
[![Travis Test Status](https://travis-ci.org/ivansible/srv-sshtun.svg?branch=master)](https://travis-ci.org/ivansible/srv-sshtun)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-ivansible.srv__sshtun-68a.svg?style=flat)](https://galaxy.ansible.com/ivansible/srv_sshtun/)

This role configures helper script and helper service for the server part
of ssh tunnel. The client(s) can be configured by the role
[wrt_sshtun](https://github.com/ivandeex/ivantory/tree/master/roles/wrt_sshtun#readme).

The script is called `sshtun-serv` and located in `/usr/local/sbin`.

The script implements three main subcommands: `boot`, `up`, `down`, `watch`
and a number of secondary subcommands convenient for troubleshooting:
  - The `boot` subcommand creates network device to be used for tunnel.
  - The `up` subcommand adds configured addresses and routes to the tunnel.
    It should be invoked as `RemoteCommand` by the SSH client during connection.
  - The `down` subcommand shuts down tunnel.
    It is not intended to be invoked directly.
  - The `watch` subcommand starts a long-running process that detects
    whether tunnel is abandoned and gracefully shuts it down.

The `sshtun` service invokes `up` at start, `down` at stop and
runs `watch` subcommand in background.

The SSH client that initiates the tunnel must perform two additional actions:
invoke the `up` subcommand and initiate a reverse socks proxy at configured
port. When the service detects that tunnel is stale, it kills SSH daemon
subprocess that controls the tunnel. It looks for the subprocess pid by
searching for a process listening on the given socks port.


## Requirements

None


## Variables

    srv_sshtun_ssh_user: ~
The SSH client will use this user to initiate the tunnel.
If user is not configured (the default), all tasks will be skipped.

    srv_sshtun_ssh_key: ~
The SSH client will use this private key to initiate the tunnel.
The role will authorize public key for this private key
if the setting is not empty.

    srv_sshtun_socks_port: 1080
The `down` subcommand will look for a pid listening on this port and
kill it assuming this is the ssh daemon child controlling the tunnel.
The tunnel client must command SSH to open a socks proxy on this port.

    srv_sshtun_gw_ipv4: ~
    srv_sshtun_gw_ipv6: ~
The `up` subcommand configures local and remote IPv4/IPv6 addresses on the
tunnel. These two settings define point-to-point subnets without the last
IP address nibble. The actual nibble will be appended to form the addresses.
The _local_ (server) address will end in `1`, the _remote_ (client) one with `2`.
For example, if `srv_sshtun_gw_ipv4` is `192.168.55`, the IPv4 addresses
of the local and remote endpoint will be `192.168.55.1` and `192.168.55.2`.

    srv_sshtun_nets_ipv4: ~
    srv_sshtun_nets_ipv6: ~
Additional routes to apply to the tunnel in the `up` subcommand.

    srv_sshtun_route_metric: 1024
Assign this priority to additional routes.

    srv_sshtun_tun: 1
The tunnel interface number where the routes and addresses will be applied.
The actual device name will be named "tunN".

    srv_sshtun_alien_devices: []
This setting is an optional array of network interface names (eg. `tun1`, `wg0` etc).
The `up` subcommand will remove our network routes from given interfaces during setup.
This can be used as a poor-man's dynamic routing.

    srv_sshtun_timeout: 10
    srv_sshtun_interval: 60
The background service checks tunnel health in loop every `interval` seconds.
Timeout is time to wait for ping reply during health checks.


## Tags

- `srv_sshtun_all` -- all tasks


## Dependencies

- `ivansible.lin_base` -- inherit common settings and the ssh restart handler
- `ivansible.lin_core` -- this role requires that ssh service is already
                          configured, but the dependency is implicit.


## Example Playbook

    - hosts: server
      roles:
         - role: ivansible.srv_sshtun
           srv_sshtun_user: ubuntu
           srv_sshtun_tun: 3
           srv_sshtun_openvpn_device: tun1
           srv_sshtun_socks_port: 21080
           srv_sshtun_gw_ipv4: 192.168.11
           srv_sshtun_gw_ipv6: fd00:11
           srv_sshtun_nets_ipv4: [192.168.1.0/24]
           srv_sshtun_nets_ipv6: [fd00:1::/64]
           srv_sshtun_route_metric: 256


## License

MIT


## Author Information

Created in 2020 by [IvanSible](https://github.com/ivansible)
