# ==Class: hosts
#
# Manage hosts entries using puppet
#
#
class hosts (
  $fqdn_entry = $::fqdn,
  $hostname_entry = $::hostname,
  $localhost_entries = [],
  $tag_collect = '',
  ) {

include concat::setup

concat {'/etc/hosts': }

concat::fragment{'hosts_head':
  target  => '/etc/hosts',
  content => "### This file is managed by Puppet.\n### Any modification will be cleared on the next Puppet run.\n",
  order   => 1,
  }

concat::fragment{'hosts_local':
  target  => '/etc/hosts',
  content => template('hosts/hosts.erb'),
  order   => 2,
  }

  $myHost = hiera_hash('hosts::hosts_entries')
  if $myHost {
  create_resources ( hosts::entries, $myHost )
  }
  $myHostExport = hiera_hash('hosts::hosts_entries_export', {})
  if $myHostExport {
  create_resources ( '@@hosts::entries', $myHostExport )
  }

  if $tag_collect != '' {

  Hosts::Entries <<| tag == $tag_collect |>>

  }

}
