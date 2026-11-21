# Troubleshooting Log

Use this page to show how you diagnose infrastructure problems. Keep entries factual and include the test that proved the fix.

## Entry template

### Issue: [short description]

- **Date:**
- **Machine:**
- **Symptoms / error:**
- **Initial checks:**
- **Diagnosis:**
- **Resolution:**
- **Verification:**
- **Evidence screenshot or output:**

## Common Active Directory lab checks

These are diagnostic starting points, not claims that these issues occurred in this lab.

### Client cannot find the domain controller

1. Run `ipconfig /all` on the client.
2. Confirm the client uses the internal DNS server (`172.16.0.1`, if that is the verified server address).
3. Run `nslookup mydomain.com`.
4. Run `nltest /dsgetdc:mydomain.com`.
5. Check DNS service status and the domain's DNS records on the server.

### Client does not receive a DHCP lease

1. Run `ipconfig /all`.
2. Check that the client is connected to the intended internal virtual network.
3. Confirm the DHCP scope is active and has available addresses.
4. Check the DHCP Server service and authorized-server status.
5. Review the DHCP lease list and relevant event logs.

### Client has no internet access

1. Confirm the server's external NIC has working connectivity.
2. Confirm the internal client has the correct default gateway.
3. Verify RRAS/NAT configuration and interface roles.
4. Test by IP address and then by DNS name to distinguish routing from name-resolution issues.

### Client cannot join the domain

1. Confirm the client can resolve the domain using the domain DNS server.
2. Confirm time synchronization is reasonable.
3. Verify connectivity to the domain controller.
4. Check the domain name and credentials used for the join.
5. Review relevant Windows event logs.

## Actual lab incidents

Add your own issues and resolutions below. Do not copy an example as if it happened to you.
