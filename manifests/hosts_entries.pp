# ==Class: hosts::entries
#
# Manage hosts entries using puppet
#
#
class hosts::entries {
  $myHost = hiera_hash('hosts::hosts_entries')
  create_resources ( host, $myHost )
 }

