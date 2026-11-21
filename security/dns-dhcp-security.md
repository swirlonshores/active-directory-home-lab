# DNS and DHCP Security Notes

Document the controls you actually applied.

## DNS

- Record which machines are configured to use the internal DNS server.
- Document the forward lookup zone and records used by the domain.
- Record any DNS forwarders configured.
- Capture successful name-resolution tests.

## DHCP

- Document the active scope and address range.
- Record DHCP options 003 (router), 006 (DNS servers), and 015 (DNS domain name), if configured.
- Confirm that only the intended internal network receives leases from this DHCP server.
- Do not expose unnecessary network details from your home network in public screenshots.

## Verification evidence

Add sanitized command output or screenshots showing the actual configuration. Do not include public IP addresses or personally identifying network details.
