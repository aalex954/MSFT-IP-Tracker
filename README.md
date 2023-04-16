# MSFT-IP-Tracker
Tracks ASN: 8068-8075 using data from stat.ripe.net

[![Publish MSFT ASN IP Ranges](https://github.com/aalex954/MSFT-IP-Tracker/actions/workflows/build_and_release.yml/badge.svg?branch=master)](https://github.com/aalex954/MSFT-IP-Tracker/actions/workflows/build_and_release.yml)

## Description

- Tracks MSFT owned ASN IP ranges and publishes a release containing a /CR /LF delineated list of Microsoft owned IPv4 and 6 ranges.
- The list is updated daily at 12 AM UTC.

Note:

Microsoft does report their own IP ranges and associated roles, which can be referenced here:

https://learn.microsoft.com/en-us/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide
https://endpoints.office.com/endpoints/worldwide?clientrequestid=b10c5ed1-bad1-445f-b386-b919946339a7


This tool just double checks 😉

## Usage

The most up to date list can be accessed via the aily releases.

https://github.com/aalex954/MSFT-IP-Tracker/releases

Update the URL in the following format: __%Y%m%d__ or __YYYYMMDD__

Example: 

- 20230415 
- yyyyMMdd
- https://github.com/aalex954/MSFT-IP-Tracker/releases/download/{%Y%m%d}/msft_asn_ip_ranges.txt


