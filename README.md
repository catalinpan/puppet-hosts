
[![Build Status](https://travis-ci.org/catalinpan/puppet-hosts.svg?branch=master)](https://travis-ci.org/catalinpan/puppet-hosts)

# hosts

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with hosts](#setup)
    * [What hosts affects](#what-hosts-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Dependencies](#dependencies)

## Overview

This module can be used to fully manage hosts entries on the servers using Puppet. The module will keep consistency of your hosts entries and will not change the order of the hosts entries.

WARNING: This module will purge any existing hosts entries

The module will always keep first 2 entries in hosts for 127.0.0.1 and ::1 in this order.

## Module Description

This module expects the server to have a hostname and a domainname. The module will ensure the consistency of the hosts entries everytime Puppet runs. This will help also facter to detect the hostname and domain name entries.
Before installing this module make sure that you have your hostname and domainname properly and matches with your puppet configs.
Facter will check for the hostname and domainname first on the /etc/hosts using "hostname" command. 

By having on the hosts:

            127.0.0.1      hostname.domainname hostname ...............

will ensure that facter will properly detect your server facts and all your exported resources will be exported everytime using the same fqdn. This will also ensure that your server will always use the same ssl key created on the initial puppet run. 


## Setup

### What hosts affects

* All your current hosts from the server will be purged.
* Make sure you specify all entries required for hosts file.
* This module has been tested on CentOS with facter 2.2.0 using hiera configs.

## Usage

Create new hosts entries:

            hosts::hosts_entries:
                     'first_entry':
                             ip: '10.0.0.200'
                             host_aliases:
                                          - 'first_entry_alias_1'
                                          - 'first_entry_alias_2'
                     'second_entry':
                             ip: '10.0.0.201'
                             host_aliases: 'second_entry_alias_1'
                     'third_entry':
                             ip: '10.0.0.201'

Any value from https://docs.puppetlabs.com/references/latest/type.html#host can be used. The only 2 mandatory values are first entry and ip.

Before first run make sure the server have the fqdn set up properly either in /etc/hosts or /etc/resolv.conf. This can be done using the above example. Facter will check first using "hostname" command, if this will fail then it will check in resolv.conf. Resolv.conf will always change depending on your network setup. To setup a custom domain (other than the one from resolv.conf) use the below entry in hiera:

            hosts::fqdn_entry: '%{hostname}.custom_domainname'

Add extra entries for localhoost

            hosts::localhost_entries: 
                                    - 'first_localhost_entry'
                                    - 'second_localhost_entry'

Export host entries:

           hosts::hosts_entries_export:
        		'exported_entry_01':
		                ip: %{::ipaddress}
                		host_aliases:
                        		- exported_entry_01_alias
                		tag: application_production

Collect exported resources:

	   hosts::tag_collect: application_production


## Limitations

This module has been tested with CentOS 6.5 with facter 2.2.0 using hiera configs.

## Dependencies

This module requires puppetlabs-concat >= 1.1.1
