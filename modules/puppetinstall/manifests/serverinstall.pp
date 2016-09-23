class puppetinstall::serverinstall{

yumrepo { 'puppetlabs-pc1':
  ensure => 'present',
  baseurl => 'http://yum.puppetlabs.com/el/7/PC1/$basearch',
  descr => 'Puppet Labs PC1 Repository el 7 - $basearch',
  enabled => '1',
  gpgcheck => '1',
  gpgkey => 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
}



file { '/etc/hosts':
		content => template('puppetinstall/hosts.erb'),
		owner   => root,
		group   => root,
		mode    => '644',
		
	}


package { 'puppetserver': ensure=>'latest'}

exec { 'source':
      command     => 'source /root/.bash_profile',
      provider => shell,
      }

service { 'puppet':
	ensure => 'running',
	}





}


