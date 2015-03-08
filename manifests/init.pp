class hosts (
	$fqdn_entry		= $::fqdn,
	$hostname_entry		= $::hostname,
	$localhost_entries	= [],
	)  {

	file { 'hosts_file':
		path	=> '/etc/hosts',
		ensure	=> present,
		owner	=> root,
		group	=> root,
		mode	=> 644,
		content	=> template("hosts/hosts.erb"),
		before	=> Class[ hosts::entries ],
		force	=> true,
		purge	=> true,
		} 

	include hosts::entries

	} 
class hosts::entries {

        $myHost = hiera_hash('hosts::hosts_entries')
	create_resources ( host, $myHost )

}	
