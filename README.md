# MSFT-IP-Tracker

[![Publish MSFT ASN IP Ranges](https://github.com/aalex954/MSFT-IP-Tracker/actions/workflows/build_and_release.yml/badge.svg?branch=master)](https://github.com/aalex954/MSFT-IP-Tracker/actions/workflows/build_and_release.yml)

---

## Description

A tool to track Microsoft IPs for use in security research, firewall configuration, routing, and troubleshooting.

- Tracks a range of ASNs and publishes a daily release containing a list of IPv4 and IPv6 address in CIDR notation.
- Release updated daily at 12 AM UTC / 7 PM EST.

_Note_

Microsoft does report their own IP ranges and associated roles, which can be referenced here:

- https://learn.microsoft.com/en-us/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide

- https://endpoints.office.com/endpoints/worldwide?clientrequestid=b10c5ed1-bad1-445f-b386-b919946339a7


This tool just double checks 😉

---

### Tracking ```32``` ASNs using data from : ```stat.ripe.net```

```3598,5761,6182,6584,8068,8069,8070,8071,8075,12076,13399,14271```

```14719,20046,23468,25796,30135,30575,32476,35106,36006,45139,52985```

```63314,395496,395524,395851,396463,397466,398575,398656,400572```

---

## Limitations

### Is it guaranteed that all IP addresses within an AS prefix belong to the assigned AS?

No, IP addresses within an AS prefix are not guaranteed to be owned by the AS that the prefix is assigned to.

> The assignment of an AS prefix to a network operator does not necessarily mean that all IP addresses within that prefix are owned or used by that network operator.
In many cases, an AS prefix may be further divided into smaller sub-prefixes or IP address ranges that are assigned or leased to other organizations, which may be different from the original AS owner. 
Additionally, IP address ownership can change over time, and some IP addresses within an AS prefix may be transferred to other entities or may become unassigned.


### Can using AS prefixes to identify traffic from a specific company?

Yes, BUT..

While using AS prefixes to identify traffic from a specific company can be useful, there are ~~some~~ a lot of potential gotchas:

- ✅ Limited scope:
  - This method only works if the company has a dedicated AS number and IP address range that is associated with their network. If the company uses a shared hosting or cloud service, it may not be possible to uniquely identify their requests based on their AS number or IP address range.
  - In this case Microsoft is large enough that its reasonable to assume they own all the IPs used to host their major products.
- ⚠ False positives:
  - It's possible that legitimate requests from a company's network may not match their AS prefix due to network changes or routing anomalies.
- ❗ False negatives:
  - It's also possible for malicious actors to spoof their IP address to make it appear as though their request is coming from a trusted AS prefix (ex. azure vm).
- ✅ Maintenance: 
  - AS prefixes are subject to change over time, and a company's network may be reassigned to a different AS number or IP address range.
  
---

## Usage

The most up to date list can be accessed via the daily releases.

- https://github.com/aalex954/MSFT-IP-Tracker/releases

### Direct download:

- [msft_asn_ip_ranges.txt](https://github.com/aalex954/MSFT-IP-Tracker/releases/latest/download/msft_asn_ip_ranges.txt)

- ```wget https://github.com/aalex954/MSFT-IP-Tracker/releases/latest/download/msft_asn_ip_ranges.txt```

---
