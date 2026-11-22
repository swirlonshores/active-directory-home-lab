### Issue: Domain join failed with incorrect username or password

- **Date:** 2026-11-21
- **Machine:** `CLIENT1` (Windows 11) and `DC` (Windows Server 2019)
- **Symptoms / error:** Attempting to join `CLIENT1` to the `MYDOMAIN.COM` domain failed with: *"The following error occurred attempting to join the domain 'MYDOMAIN.COM': The user name or password is incorrect."*
- **Initial checks:** Verified `CLIENT1` hostname and domain-change dialog in Windows Settings/System Properties while reviewing Active Directory Users and Computers (`mydomain.com`) on `DC`.
- **Diagnosis:** The account/password used during the domain-join attempt did not match the current Active Directory credentials on `DC`.
- **Resolution:** Located the user account in Active Directory Users and Computers on `DC` and reset the password via **Reset Password**, then re-submitted the domain join for `CLIENT1` to `MYDOMAIN.COM`.
- **Verification:** Received the *"Welcome to the MYDOMAIN.COM domain"* prompt, confirmed `CLIENT1` listed under `Computers` in Active Directory Users and Computers on `DC`, and verified `Full device name: CLIENT1.mydomain.com` in Windows Settings (`System > About`).
- **Evidence screenshot or output:** `password lockout reset.jpg`, `password reset successful.jpg`, `successful join.jpg`

### Issue: Domain user sign-in blocked by disabled account

- **Date:** 2026-11-21
- **Machine:** Windows 11 client VM and `DC` (Windows Server 2019)
- **Symptoms / error:** Sign-in screen displayed *"Your account has been disabled. Please see your system administrator."*
- **Initial checks:** Inspected user accounts under the `_USERS` organizational unit in Active Directory Users and Computers on `DC` and checked the affected user account (`mjarrett`).
- **Diagnosis:** The target Active Directory user account was disabled or had an invalid sign-in state preventing domain authentication on the client VM.
- **Resolution:** Enabled/updated the `mjarrett` user account in Active Directory Users and Computers on `DC` and signed into the client VM with the domain user account.
- **Verification:** Opened Command Prompt on the client VM and ran `whoami`, confirming the active session context as `mydomain\mjarrett`.
- **Evidence screenshot or output:** `all users disabled.jpg`, `usermjarrettlogintocorperatedomain.jpg`