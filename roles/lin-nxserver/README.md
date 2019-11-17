# ivansible.lin_nxserver

This role provisions [nomachine](https://www.nomachine.com/) nxserver on a linux box.
Additionally, it can enable swap and install `xvfb`.


## Requirements

None


## Role Variables

Available variables are listed below, along with default values.

    allow_reboot: true

If `true`, the script will reboot target host after critical upgrade.
Otherwise, the script will print a warning message and skip rebooting.

    lin_nxserver_deb_url: https://download.nomachine.com/download/6.6/Linux/nomachine_6.6.8_5_amd64.deb
URL of nxserver package.

    lin_nxserver_display: 1001
The role will add this `DISPLAY` variable to the user `bashrc` file.

    lin_nxserver_port: 4000
You should not usually change this.

    lin_swap_enable: no
Enables or disables confiration of swap file.

    lin_swap_file: /swap
Path to the swap file.

    lin_swap_mb: 1024
Swap file size in megabytes,


## Tags

- `lin_nx_server` -- install nxserver package and open ports
- `lin_nx_user` -- authorize user
- `lin_nx_desktop` -- install `xfce4` desktop environment
- `lin_nx_audio` -- enable audio interface in nxserver
- `lin_nx_swap` -- setup swap space
- `lin_nx_all` -- all of above


## Dependencies

None


## Example Playbook

    - hosts: nxhost
      roles:
         - role: ivansible.lin_nxserver
           lin_swap_enable: yes
           lin_swap_mb: 2048


## License

MIT

## Author Information

Created in 2018 by [IvanSible](https://github.com/ivansible)
