# ==Class: hosts::entries
#
# Manage hosts entries using puppet
#
#
class hosts::entries {
  $myHost = hiera_hash('hosts::hosts_entries')
  if $myHost {
  create_resources ( host, $myHost )
  }

  $myHostExport = hiera_hash('hosts::hosts_entries_export', {})
  if $myHostExport {
  create_resources ( '@@host', $myHostExport )
  }

}

