# Loops through a range of AS Numbers and stores the resulting IP address ranges in a text file called asn_ip_ranges.txt

$as_first = 8068
$as_last = 8075
$current_asn = $as_first
$url = "https://stat.ripe.net/data/announced-prefixes/data.json?resource=as$as_number"

for ($current_asn; $current_asn -le $as_last; $current_asn++) {

    $response = Invoke-RestMethod -Uri $url -Method Get

    if ($response.status -eq "ok") {
        $prefixes = $response.data.prefixes

        Write-Host ";$current_asn"
        "`r`nASN: $current_asn`r`n" | Out-File -FilePath "asn_ip_ranges.txt" -Encoding utf8 -Append

        foreach ($prefix in $prefixes) {
            Write-Host "$($prefix.prefix)"
            $($prefix.prefix) | Out-File -FilePath "asn_ip_ranges.txt" -Encoding utf8 -Append
            $($prefix.prefix) | Out-File -FilePath "blacklist.txt" -Encoding utf8 -Append
        }
    } else {
        Write-Host "Error: $($response.status) - $($response.status_message)"
    }
}