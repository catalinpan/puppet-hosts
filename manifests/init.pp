# ==Class: hosts
#
# Manage hosts entries using puppet
#
#
class hosts (
 $fqdn_entry = $::fqdn,
 $hostname_entry = $::hostname,
 $localhost_entries = [],
 ) {
 file { 'hosts_file':
 path    => '/etc/hosts',
 owner   => root,
 group   => root,
 mode    => '0644',
 content => template("hosts/hosts.erb"),
 before  => Class[ hosts::entries ],
 force   => true,
 purge   => true,
 }
 include hosts::entries
 } 
