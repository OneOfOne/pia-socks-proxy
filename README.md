# A socks5 proxy via Private Internet Access.

An [Alpine](https://alpinelinux.org/) Linux container running a socks5 proxy (using [dante](https://www.inet.no/dante/)) via Private Internet Access (OpenVPN).

Protect your browsing activities through an encrypted and anonymized VPN proxy!

You will need a [PrivateInternetAccess](https://www.privateinternetaccess.com/pages/how-it-works) account.
If you don't have one, you can [sign up here](https://www.privateinternetaccess.com/pages/buy-vpn) for one.

[![Docker Build Status](https://img.shields.io/docker/build/oneofone/pia-socks-proxy.svg?style=flat-square)]()
[![Docker Build Status](https://img.shields.io/docker/automated/oneofone/pia-socks-proxy.svg?style=flat-square)]()
[![Docker Build Status](https://img.shields.io/docker/pulls/oneofone/pia-socks-proxy.svg?style=flat-square)]()
[![Docker Build Status](https://img.shields.io/docker/stars/oneofone/pia-socks-proxy.svg?style=flat-square)]()


## Starting the VPN Proxy

```sh
docker run -d \
--cap-add=NET_ADMIN \
--device=/dev/net/tun \
--name=pia-socks-proxy \
--restart=always \
-e "USERNAME=<pia_username>" \
-e "PASSWORD=<pia_password>" \
-e "REGION=<region>" \ # default US East
-e "DNS=<dns servers" \ # default: cloudflare's tls servers 1.1.1.1@853#cloudflare-dns.com 1.0.0.1@853#cloudflare-dns.com
-e "ENCRYPTION=[strong|normal]" # default: strong
-e "PROTOCOL=[udp|tcp]" #default: udp
-p 1080:1080 \
oneofone/pia-socks-proxy
```

Substitute the environment variables for `REGION`, `USERNAME`, `PASSWORD` as indicated.

A `docker-compose-dist.yml` file has also been provided. Copy this file to `docker-compose.yml` and substitute the environment variables are indicated.

Then start the VPN Proxy via:

```sh
docker-compose up -d
```

### Environment Variables

`REGION` is optional. The default region is set to `US East`. `REGION` should match the supported PIA `.opvn` region config.

See the [PIA VPN Tunnel Network page](https://www.privateinternetaccess.com/pages/network) for details.
Use the `Location` value for your `REGION`.

`USERNAME` / `PASSWORD` - Credentials to connect to PIA

## Connecting to the VPN Proxy

To connect to the VPN Proxy, set your browser socks5 proxy to localhost:1080.

### Recommended (100% personal preference) addons

- Chrome: [ProxySwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif)

- Firefox: [ProxySwitcher](https://addons.mozilla.org/en-US/firefox/addon/proxy-switcher/)

### Commend line

- curl:

```shell
# socks5h so the dns is done over the socks proxy
$ curl -v --proxy socks5h://localhost:1080
```

- git:

```shell
env ALL_PROXY=socks5h://localhost:1080 git clone https://github.com/some/one.git
```

## Credits

- [act28/pia-openvpn-proxy](https://github.com/act28/pia-openvpn-proxy), used the openvpn config from his image, but he uses privoxy rather than socks5.
- [qmcgaw/private-internet-access](https://github.com/qdm12/private-internet-access-docker) unbound config + dynamically download the latest PIA configs.
