# ==Define: hosts::entries
#
# Manage hosts entries using puppet
#
#
define hosts::entries (
  $host_aliases = [],
  $ip = '',
  ) {

concat::fragment{"hosts_${title}":
  target  => '/etc/hosts',
  content => template('hosts/entries.erb'),
  order   => '99',
  }
}
