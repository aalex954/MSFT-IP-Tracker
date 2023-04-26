# Loops through a range of AS Numbers and stores the resulting IP address ranges in a text file called asn_ip_ranges.txt

$asNumbers = @(3598,5761,6182,6584,8068,8069,8070,8071,8075,12076,13399,14271,14719,20046,23468,25796,30135,30575,32476,35106,36006,45139,52985,63314,395496,395524,395851,396463,397466,398575,398656,400572)
$baseUrl = "https://stat.ripe.net/data/announced-prefixes/data.json?resource=AS"

foreach ($asNumber in $asNumbers){
    $url = $baseUrl + $asNumber

    try {
        $response = Invoke-RestMethod -Uri $url -Method Get
    } catch {
        "Connection to the server failed"
    }

    if ($response.status -eq "ok"){
        foreach ($prefix in $response.data.prefixes){
            $($prefix.prefix) | Out-File -FilePath "msft_asn_ip_ranges.txt" -Encoding utf8 -Append
        }
    } else {
        Write-Host "Error: $($response.status) - $($response.status_message)"
    }
}
