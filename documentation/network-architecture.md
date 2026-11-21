# Network Architecture

## Overview

The supplied topology depicts a small two-network Active Directory lab. The Windows Server 2019 machine acts as the domain controller and is shown with two network interfaces:

- An external interface connected to the home network/internet and configured to obtain an address by DHCP.
- An internal interface connected to the private lab network with a static address.

A Windows 10 client is connected to the internal network and is intended to receive its network configuration from the domain controller's DHCP service.

## Topology

The original diagram is stored at [`../screenshots/network-topology-original.png`](../screenshots/network-topology-original.png).

## Addressing shown in the diagram

| Device / setting | Value shown |
|---|---|
| Domain | `mydomain.com` |
| Server OS | Windows Server 2019 |
| Client OS | Windows 10 |
| Server internal IPv4 | `172.16.0.1` |
| Internal subnet mask | `255.255.255.0` |
| Server internal DNS field | `127.0.0.1` |
| DHCP range | `172.16.0.100`–`172.16.0.200` |
| DHCP subnet mask | `255.255.255.0` |
| DHCP DNS server | `172.16.0.1` |
| External interface | DHCP from home router |
| Internal client interface | DHCP from domain controller |

## Network services represented

### Active Directory Domain Services

AD DS provides centralized identity and domain services for the `mydomain.com` domain. The Windows Server 2019 system is represented as the domain controller.

### DNS

Domain-joined Windows clients rely on DNS to locate domain services. The diagram shows the domain controller's internal DNS address as `172.16.0.1` in the DHCP configuration. The server's own NIC is shown with `127.0.0.1` as its DNS setting.

Verify the DNS server role, forward lookup zone, host records, and client DNS configuration in the running lab. Capture screenshots of DNS Manager and successful name-resolution tests.

### DHCP

The diagram shows one DHCP scope:

- Start: `172.16.0.100`
- End: `172.16.0.200`
- Subnet mask: `255.255.255.0`
- DNS server: `172.16.0.1`

The diagram's gateway entry appears as `172.168.0.1`. This does not match the `172.16.0.0/24` internal subnet and is likely a typo. **Do not copy this value without checking the actual DHCP scope.** If the Windows Server is routing/NATing the internal network, the expected internal default gateway would normally be the server's internal address, `172.16.0.1`; verify the actual RRAS design and DHCP option 003 before documenting it as configured.

### RRAS / NAT

The diagram represents Routing and Remote Access (RRAS) with NAT, with the external interface facing the internet and the internal interface serving the lab network.

Verify the RRAS configuration and test outbound connectivity from the client before marking this service complete.

## Items to verify before publishing as final

1. **Hypervisor label:** The diagram labels a “VMWare Network” but also lists “VirtualBox” at the bottom. Confirm whether the lab was built in VMware or VirtualBox, then update the diagram or explain the difference.
2. **DHCP gateway:** The shown `172.168.0.1` value does not match the internal subnet. Check the actual DHCP scope.
3. **DNS on the domain controller:** The diagram shows `127.0.0.1` on the internal NIC. Confirm the actual adapter DNS setting and DNS server configuration.
4. **DHCP client lease:** Verify the Windows 10 client receives an address in the intended scope and uses the domain controller for DNS.
5. **Domain membership:** Verify the client is actually joined to `mydomain.com`.
6. **NAT:** Verify that the client can reach the internet through the server, if NAT is part of the completed lab.

## Suggested evidence

Add screenshots to `../screenshots/` and describe what each screenshot proves. Do not include passwords, keys, personal information, or public IP details.
