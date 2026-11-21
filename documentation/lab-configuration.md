# Lab Configuration Notes

Use this file as a record of the configuration in your own virtual machines. The values in the first table are transcribed from the supplied topology diagram; confirm them against the live lab.

## Configuration represented in the diagram

| Component | Diagram value |
|---|---|
| Server | Windows Server 2019 |
| Client | Windows 10 |
| Domain FQDN | `mydomain.com` |
| Server internal NIC | `172.16.0.1/24` |
| Server internal DNS | `127.0.0.1` |
| DHCP scope | `172.16.0.100`–`172.16.0.200` |
| DHCP mask | `255.255.255.0` |
| DHCP DNS | `172.16.0.1` |
| DHCP gateway | Diagram appears to say `172.168.0.1` — verify |
| External NIC | DHCP from home router |
| Services | AD DS, DNS, DHCP, RRAS/NAT |

## Record your actual settings

Fill in the following from the running lab:

- Hypervisor and version:
- Domain controller hostname:
- Domain FQDN:
- External NIC name and addressing method:
- Internal NIC name and IPv4 address:
- DNS server role status:
- DHCP scope ID:
- DHCP lease observed on client:
- DHCP option 003 (router):
- DHCP option 006 (DNS servers):
- RRAS/NAT status:
- Client hostname:
- Client domain-join status:

## Verification commands

Run these on the appropriate machine and save sanitized output in `../evidence/`.

### On the Windows Server

```powershell
ipconfig /all
Get-WindowsFeature AD-Domain-Services, DNS, DHCP, RemoteAccess
Get-Service DNS, DHCPServer
Get-ADDomain
Get-DhcpServerv4Scope
Get-DhcpServerv4OptionValue
```

Some commands require the relevant Windows Server roles or PowerShell modules. Run an elevated PowerShell session.

### On the Windows client

```powershell
ipconfig /all
whoami
systeminfo | findstr /B /C:"Domain"
nslookup mydomain.com
nltest /dsgetdc:mydomain.com
```

Record the result, date, machine, and any error message. Remove personal or sensitive details before publishing.
