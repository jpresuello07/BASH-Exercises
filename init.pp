class package-install{
  package {'git':
    ensure => 'installed',
  }
  
  package {'curl':
	ensure => 'present',
  }
  
  package {'vim':
	ensure => 'installed'
  }
  
}

class create-user{
	user { 'monitor':
		ensure 	=> 'present',
		home 	=> '/home/monitor',
		shell	=> '/bin/bash'
	}
  
}

class create-dir{
	file { '/home/monitor/scripts/':
		ensure => 'directory';

}