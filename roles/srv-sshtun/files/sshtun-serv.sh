#!/bin/bash
#set -x

device=tun1
alien_devices=""
socks_port=1080

timeout=10
interval=60

ip4gw=10.1.1
ip6gw=fd00:1

ip4nets=""
ip6nets=""
metric=1024

# shellcheck disable=SC1091
. /etc/default/sshtun-serv

ip4local="${ip4gw}.1"
ip4peer="${ip4gw}.2"
ip6local="${ip6gw}::1"
ip6peer="${ip6gw}::2"

boot()
{
    ip link show dev "$device" &>/dev/null || \
    ip tuntap add "$device" mode tun
}

flush()
{
    ip -4 addr  flush dev "$device"
    ip -6 addr  flush dev "$device"
    ip -4 route flush dev "$device"
    ip -6 route flush dev "$device"
}

up()
{
    ip link set dev "$device" up
    flush >/dev/null 2>&1

    ip -4 addr add "$ip4local/30"  peer "$ip4peer" dev "$device"
    ip -6 addr add "$ip6local/126" peer "$ip6peer" dev "$device"

    local net alien_dev

    for net in $ip4nets ; do
        for alien_dev in $alien_devices ; do
            ip -4 route del "$net" dev "$alien_dev" 2>/dev/null || true
        done
        ip -4 route replace "$net" dev "$device" metric "$metric"
    done

    for net in $ip6nets ; do
        for alien_dev in $alien_devices ; do
            ip -6 route del "$net" dev "$alien_dev" 2>/dev/null || true
        done
        ip -6 route replace "$net" dev "$device" metric "$metric"
    done

    logger -t 'sshtun' -i 'ssh tun up'
}

down()
{
    local pids

    pids=$(ss --listening --tcp --numeric --processes |
           awk "\$4 ~ /:${socks_port}\$/ && \$6 ~ /sshd/ { match(\$6, /pid=([0-9]+)/, m); print m[1]; }" |
           sort -u)

    if [ -n "$pids" ]; then
        logger -t 'sshtun' -i 'ssh tun down'
        for signal in TERM TERM KILL; do
            # shellcheck disable=SC2086
            kill -s "$signal" $pids 2>/dev/null
            sleep 0.6
        done
    fi

    flush >/dev/null 2>&1
    ip link set "$device" down
}

check()
{
    ping -c 1 -w "$timeout" -I "$device" "$ip4peer" &>/dev/null
}

watch()
{
    while true; do
        check || down
        sleep "$interval"
    done
}

case "$1" in
    boot|up|down|watch)  "$1" ;;
    check)  check; echo $? ;;
    *) echo "usage: $0 boot|up|down|check|watch" ;;
esac
