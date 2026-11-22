# Lab Configuration Notes


## Configuration represented in the diagram

| Component | Diagram value |
|---|---|
| Server | Windows Server 2019 |
| Client | Windows 10 (updated to Windows 11 Pro in live lab) |
| Domain FQDN | `mydomain.com` |
| Server internal NIC | `172.16.0.1/24` |
| Server internal DNS | `127.0.0.1` |
| DHCP scope | `172.16.0.100`–`172.16.0.200` |
| DHCP mask | `255.255.255.0` |
| DHCP DNS | `172.16.0.1` |
| DHCP gateway | Diagram appears to say `172.168.0.1` — verify |
| External NIC | DHCP from home router |
| Services | AD DS, DNS, DHCP, RRAS/NAT |



Fill in the following from the running lab:

- Hypervisor and version: Oracle VirtualBox 7.2.8
- Domain controller hostname: `DC`
- Domain FQDN: `mydomain.com`
- External NIC name and addressing method: `_INTERNET_` — DHCP (`10.0.2.15/24`, gateway `10.0.2.2`, DHCP server `10.0.2.2`)
- Internal NIC name and IPv4 address: `X_Internal_X` — `172.16.0.1/24` (static, DHCP disabled)
- DNS server role status: Running (`DNS` service active on `DC.mydomain.com`; `CLIENT1` resolves `mydomain.com` to `172.16.0.1`)
- DHCP scope ID: `172.16.0.0` (scope range `172.16.0.100`–`172.16.0.200`, subnet mask `255.255.255.0`)
- DHCP lease observed on client: `172.16.0.100/24` from DHCP server `172.16.0.1` (obtained Nov 22, 2026)
- DHCP option 003 (router): `172.16.0.1`
- DHCP option 006 (DNS servers): `172.16.0.1`
- RRAS/NAT status: `IP Routing Enabled: Yes` on `DC` (confirm RRAS/RemoteAccess service status)
- Client hostname: `CLIENT1` (Windows 11 Pro, Build 26300)
- Client domain-join status: Not currently domain-joined (`client1\sandi`, Member Workstation); DNS resolution to `mydomain.com` (`172.16.0.1`) is working


### On the Windows Server

```powershell
ipconfig /all
Get-WindowsFeature AD-Domain-Services, DNS, DHCP, RemoteAccess
Get-Service DNS, DHCPServer
Get-ADDomain
Get-DhcpServerv4Scope
Get-DhcpServerv4OptionValue