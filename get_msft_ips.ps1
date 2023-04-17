# Loops through a range of AS Numbers and stores the resulting IP address ranges in a text file called asn_ip_ranges.txt


# Analytics csv
$global:ASN_ANALYTICS = @("Name,CountryCode,Description,ASN")

function Get-ASNInfo {
    param (
        $OrganizationName = "microsoft"
    )
    $url = "https://api.bgpview.io/search?query_term=$OrganizationName"
    #$response = Invoke-RestMethod -Uri $url -Method Get
    $response.status = "ok"

    if ($response.status -eq "ok") {
        # $asnInfo = $response | ConvertFrom-Json 
        $asnInfo = Get-Content .\msft_asns_bgpview.json -Raw | ConvertFrom-Json
        $asns = $AsnInfo.data.asns
        $asnValues = @()
        $data = @("Name,CountryCode,Description,ASN")
        foreach ($asn in $asns) {
            $asnValues += $asn | Select-Object asn | Select-Object -ExpandProperty asn
            # Input sanitization for extra commas
            $data += "$($asn.name -replace ","),$($asn.country_code -replace ","),$($asn.description -replace ","),$($asn | Select-Object asn | Select-Object -ExpandProperty asn)"
        }
        $global:ASN_ANALYTICS = $data

    }
    else {
        Write-Host "Error: $($response.status) - $($response.status_message)"
    }
    return $asnValues | Sort-Object
}

function Get-ASNPrefixes {
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        $ASN
    )
    $url = "https://stat.ripe.net/data/announced-prefixes/data.json?resource=$ASN"
    #$response = Invoke-RestMethod -Uri $url -Method Get
    $response.status = "ok"

    if ($response.status -eq "ok") {
        # TESTING : $asnPrefixInfo = $response | ConvertFrom-Json
        $asnPrefixInfo = Get-Content .\ripe_prefix.json -Raw | ConvertFrom-Json
        $prefixes = $asnPrefixInfo.data.prefixes
        $prefixValues = @()

        foreach ($prefix in $prefixes) {
            echo $prefix.prefix
            $prefixValues += $prefix.prefix
        }
    }
    else {
        Write-Host "Error: $($response.status) - $($response.status_message)"
    }
    return $prefixValues
}

function Write-ASNAnalytics {
    param (
        # [Parameter(Mandatory = $true)]
        # $asn_analytics,
        [Parameter(Mandatory = $true)]
        $asn_prefixes
    )
    $asn_analytics = $global:ASN_ANALYTICS

    #WORKING TILL HERE

    #$UniqueCountryCodesCount = ($global:asn_analytics | Select-Object CountryCode | Get-Unique | Measure-Object).Count
    $UniqueCountryCodesCount = ($global:asn_analytics | ConvertFrom-Csv -Delimiter ',' | Select-Object CountryCode | Select-Object -ExpandProperty CountryCode | Sort-Object -Unique).count
    $UniqueASN = ($global:asn_analytics | ConvertFrom-Csv -Delimiter ',' | Select-Object ASN | Select-Object -ExpandProperty ASN | Sort-Object {[int]$_}) -join ','
    $UniqueASNCount = ($global:asn_analytics | ConvertFrom-Csv -Delimiter ',' | Select-Object ASN | Select-Object -ExpandProperty ASN | Sort-Object -Unique).count
    $UniqueNames = ($global:asn_analytics | ConvertFrom-Csv -Delimiter ',' | Select-Object Name | Select-Object -ExpandProperty Name | Sort-Object) -join ','
    $UniqueNamesCount = ($global:asn_analytics | ConvertFrom-Csv -Delimiter ',' | Select-Object Name | Select-Object -ExpandProperty Name | Sort-Object -Unique).count
    $UniqueDescriptions = ($global:asn_analytics | ConvertFrom-Csv -Delimiter ',' | Select-Object Description | Select-Object -ExpandProperty Description | Sort-Object) -join ','
    $UniqueDescriptionsCount = ($global:asn_analytics | ConvertFrom-Csv -Delimiter ',' | Select-Object Description | Select-Object -ExpandProperty Description | Sort-Object -Unique).count

    $UniquePrefixes = ($asn_prefixes | Get-Unique )
    $UniquePrefixCount = ($asn_prefixes | Get-Unique | Measure-Object).Count

    Write-Host "UniqueCountryCodesCount: $UniqueCountryCodesCount"
    Write-Host "UniqueASN: $UniqueASN"
    Write-Host "UniqueASNCount: $UniqueASNCount"
    Write-Host "UniqueNames: $UniqueNames"
    Write-Host "UniqueNamesCount: $UniqueNamesCount"
    Write-Host "UniqueDescriptions: $UniqueDescriptions"
    Write-Host "UniqueDescriptionsCount: $UniqueDescriptionsCount"

    #Write-Host "UniquePrefixes: $UniquePrefixes"
    Write-Host "UniquePrefixCount: $UniquePrefixCount"

    $output = "
UniqueCountryCodesCount: $UniqueCountryCodesCount`n
UniqueASN: $UniqueASN`n
UniqueASNCount: $UniqueASNCount`n
UniqueNamesCount: $UniqueNamesCount`n
UniqueDescriptions: $UniqueDescriptions`n
UniqueDescriptionsCount: $UniqueDescriptionsCount`n
UniquePrefixes: UniquePrefixes`n
UniquePrefixCount $UniquePrefixCount`n
"
    Write-Host "Exporting to: $PWD\asn_analytics.txt"

    $output | Out-File -FilePath "$PWD\asn_analytics.txt" -Encoding utf8 -Force
}
# -------------------------------------------------------------------------------------------------------

# Get all asn for a given org name
$ASNumbers = Get-ASNInfo -OrganizationName "microsoft"


# Get all prefixes assoiciated with each AS number
$ASNPrefixes = @()
foreach ($ASNumber in ($ASNumbers | Sort-Object)) {
    echo "main log: $ASNumber"
    $ASNPrefixes += Get-ASNPrefixes -ASN $ASNumber
}

# Write analytics file to working dir
Write-ASNAnalytics -asn_prefixes $ASNPrefixes

# Write all prefixes to file
$ASNPrefixes | Out-File -FilePath "asn_ip_ranges.txt" -Encoding utf8 -Force
