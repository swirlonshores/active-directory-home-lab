# Network Architecture

## Overview

The topology depicts a two-network Active Directory lab running in **Oracle VirtualBox 7.2.8**. A **Windows Server 2019** machine (`DC`) acts as the domain controller for `mydomain.com` with two network interfaces:

- An external interface (`_INTERNET_`) connected to the home network/internet via DHCP (`10.0.2.15/24`, default gateway `10.0.2.2`).
- An internal interface (`X_Internal_X`) connected to the private lab network with a static IPv4 address (`172.16.0.1/24`).

A **Windows 11 Pro** client (`CLIENT1`, Build `26300`) is connected to the internal lab network and receives its IP configuration via DHCP from `172.16.0.1`.



The diagram is stored in `../screenshots/` (verify the screenshot filename in your repository and ensure `CLIENT1` is labeled as Windows 11 rather than Windows 10).

## Addressing shown in the diagram vs. verified lab

| Device / setting | Diagram / initial value | Verified lab value |
|---|---|---|
| Domain | `mydomain.com` | `mydomain.com` |
| Server OS | Windows Server 2019 | Windows Server 2019 (`DC`) |
| Client OS | Windows 10 | Windows 11 Pro (`CLIENT1`, Build `26300`) |
| Server internal IPv4 | `172.16.0.1` | `172.16.0.1` (`X_Internal_X`) |
| Internal subnet mask | `255.255.255.0` | `255.255.255.0` |
| Server internal DNS field | `127.0.0.1` | `127.0.0.1` (and `::1`) |
| DHCP range | `172.16.0.100`–`172.16.0.200` | Lease observed at `172.16.0.100` (`255.255.255.0`) |
| DHCP subnet mask | `255.255.255.0` | `255.255.255.0` |
| DHCP DNS server | `172.16.0.1` | `172.16.0.1` |
| DHCP gateway | `172.168.0.1` (diagram typo) | `172.16.0.1` |
| External interface | DHCP from home router | DHCP (`_INTERNET_`, `10.0.2.15/24`, GW `10.0.2.2`) |
| Internal client interface | DHCP from domain controller | DHCP (`172.16.0.100/24` from `172.16.0.1`) |

## Network services represented

### Active Directory Domain Services

AD DS is deployed on `DC.mydomain.com` (`mydomain` / `MYDOMAIN`) to provide centralized directory and domain services for the `mydomain.com` domain.

### DNS

The Windows DNS Server service is running on `DC` (`172.16.0.1`). `CLIENT1` receives `172.16.0.1` as its DNS server via DHCP and resolves `mydomain.com` to `172.16.0.1` (along with `10.0.2.15` and IPv6 addresses).

### DHCP

The DHCP scope (`172.16.0.100`–`172.16.0.200` on `172.16.0.0/24`) is active and serving `CLIENT1`, which obtained `172.16.0.100/24` from DHCP server `172.16.0.1`.

The diagram's `172.168.0.1` gateway value was a typo—the actual gateway and DHCP option 003/006 values observed on `CLIENT1` are `172.16.0.1`.

### RRAS / NAT

`IP Routing Enabled` is `Yes` on `DC`. Confirm the Routing and Remote Access / NAT configuration and test outbound internet connectivity from `CLIENT1` before marking NAT/routing complete.

## Verification checklist

1. **Hypervisor & OS labels:** Lab runs on **Oracle VirtualBox 7.2.8** with **Windows Server 2019** (`DC`) and **Windows 11 Pro** (`CLIENT1`)—update any leftover Windows 10 or mismatched hypervisor labels in diagrams/notes.
2. **DHCP gateway:** Confirmed `172.16.0.1` (replacing the `172.168.0.1` diagram typo).
3. **DNS on the domain controller:** Confirmed DNS service is running on `DC` and `CLIENT1` resolves `mydomain.com`.
4. **DHCP client lease:** Confirmed `CLIENT1` received `172.16.0.100/24` with gateway `172.16.0.1` and DNS `172.16.0.1`.
5. **Domain membership:** `CLIENT1` is currently a standalone/workgroup member (`client1\sandi`, Member Workstation)—join `CLIENT1` to `mydomain.com` if full domain-joined client testing is part of your lab scope.
6. **NAT:** Verify outbound connectivity from `CLIENT1` through `DC` (`172.16.0.1`).

