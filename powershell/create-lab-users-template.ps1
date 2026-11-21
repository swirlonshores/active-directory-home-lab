# Creates a single lab test account in the Lab-Users OU.
# Review the username and display name before running.
# The script prompts securely for the password; no password is stored here.

Import-Module ActiveDirectory

$domain = Get-ADDomain
$ouPath = "OU=Lab-Users,$($domain.DistinguishedName)"

$SamAccountName = Read-Host "Enter a test username (sAMAccountName)"
$DisplayName = Read-Host "Enter a display name for the test account"

if ([string]::IsNullOrWhiteSpace($SamAccountName) -or
    [string]::IsNullOrWhiteSpace($DisplayName)) {
    throw "Username and display name are required."
}

$existingUser = Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue
if ($existingUser) {
    Write-Host "User already exists: $SamAccountName"
    return
}

$Password = Read-Host "Enter a temporary lab password" -AsSecureString

New-ADUser `
    -Name $DisplayName `
    -DisplayName $DisplayName `
    -SamAccountName $SamAccountName `
    -UserPrincipalName "$SamAccountName@$($domain.DNSRoot)" `
    -Path $ouPath `
    -AccountPassword $Password `
    -Enabled $true `
    -ChangePasswordAtLogon $true

Write-Host "Created enabled lab account: $SamAccountName"
