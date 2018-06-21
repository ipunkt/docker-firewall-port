# docker-firewall-port
Use iptables to firewall off a single port on the host

## Use

## Parameters
Parameters are given as environment variable. The following parameters are available
- PORT, default `111`
- PROTOCOL, default `UDP`. Use `ANY` to not filter by protocol
- ALLOWED\_ADDRESSES, REQUIRED. Allowed ip addresses separated by `,`,`;` or ` `

## Use-case
This image was created with the intend to automatically firewall off port 111 on
Rancher droplets, only accepting traefik from the nfs server serving permanent
storage without opening the port to the world, allowing reflection ddos attacks
on others using our machine.
