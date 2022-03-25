# ivansible.dns_cloudflare

[![Github Test Status](https://github.com/ivansible/dns-cloudflare/workflows/Molecule%20test/badge.svg?branch=master)](https://github.com/ivansible/dns-cloudflare/actions)
[![Travis Test Status](https://travis-ci.org/ivansible/dns-cloudflare.svg?branch=master)](https://travis-ci.org/ivansible/dns-cloudflare)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-ivansible.dns__cloudflare-68a.svg?style=flat)](https://galaxy.ansible.com/ivansible/dns_cloudflare/)

This role configures cloudflare records from inventory variables.


## Requirements

None


## Variables

    dns_cloudflare_zones:
      example.com:
        special:
          - name: example.com
            type: MX
            value: mail.example.com
            priority: 10
            proxied: false
          - name: example.com
            type: TXT
            value: 'v=spf1 ip4:127.0.0.1 a:mail.example.com mx ~all'
        proxied:
          alias1: host.example.com
          '@': [127.0.0.1, 2001:db8::2]
          www: example.com
        direct:
          alias2: null.deex.fun
          direct1: [127.0.0.1]
          direct2: [127.0.0.1, 2001:db8::2]

The map where keys are names of cloudflare zones, which should be created in advance.
For every zone the following fields can be defined: `direct`, `proxied` and `special`.
All fields are optional.

The `direct` and `proxied` fields define _A_, _AAAA_ and _CNAME_ records in the zone.
They have the same structure, the only difference is whether created records
will be proxied by the Cloudflare CDN or not.
Both fields are maps of key/value items for zone records.
The key defines record name.
The special key of `@` defines a record with the same name as containing zone.
If the value is a string, the item defines a _CNAME_ record.
Otherwise, the value must be a list of IPv4 and IPv6 addresses
(probably with a single element).
The role will create records of appropriate type
depending on the syntax of particular list element.

The `special` field is an optional list, which defines non-address non-alias records
in the zone. Every item in the list should have the following fields:
  - `name` - name of the record;
  - `type` - one of: _MX_, _NS_, _SPF_, _TXT_;
  - `value` - usually a fully qualified host name or IP address,
              depends on type of record;
  - `proxied` - optional, defaults to _false_;
  - `priority` - numeric priority, valid only for _MX_ records.

```
    dns_cloudflare_email: ~
    dns_cloudflare_token: ~
```
CloudFlare credentials (required).

    dns_cloudflare_only_zone: example.com
This setting can be used for role debugging, usually used as a CLI argument.
If defined, only the given zone will updated.
By default it's undefined, and the role updates all configured zones.


## Tags

- `dns_cloudflare_all` - all tasks


## Dependencies

None


## Example Playbook

    - hosts: localhost
      roles:
         - role: ivansible.dns_cloudflare
           dns_cloudflare_zones:
             example.com:
               proxied:
                 alias1: host.example.com
                 '@': [127.0.0.1, 2001:db8::2]
                 www: example.com
           dns_cloudflare_only_zone: example.com


## License

MIT


## Author Information

Created in 2020 by [IvanSible](https://github.com/ivansible)
