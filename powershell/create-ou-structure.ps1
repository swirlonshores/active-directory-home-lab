# Create a basic OU structure in the current AD domain.
# Run in an elevated PowerShell session with the ActiveDirectory module.
# Review the names before running in your lab.

Import-Module ActiveDirectory

$domain = Get-ADDomain
$domainDN = $domain.DistinguishedName

$ouNames = @(
    "Lab-Users",
    "Lab-Computers",
    "Lab-Groups",
    "Lab-ServiceAccounts"
)

foreach ($ouName in $ouNames) {
    $existingOU = Get-ADOrganizationalUnit -LDAPFilter "(ou=$ouName)" -SearchBase $domainDN -ErrorAction SilentlyContinue

    if ($null -eq $existingOU) {
        New-ADOrganizationalUnit -Name $ouName -Path $domainDN -ProtectedFromAccidentalDeletion $true
        Write-Host "Created OU: $ouName"
    }
    else {
        Write-Host "OU already exists: $ouName"
    }
}
