# This class replace "hosts" file
# Install puppet server and run it
class puppetinstall::serverinstall(
  $server_version = '2.6.0-1.el7',
)
{
  yumrepo { 'puppetlabs-pc1':
    ensure   => 'present',
    baseurl  => 'http://yum.puppetlabs.com/el/7/PC1/$basearch',
    descr    => 'Puppet Labs PC1 Repository el 7 - $basearch',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
  }

  file { '/etc/hosts':
    content => template('puppetinstall/hosts.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Yumrepo['puppetlabs-pc1'],
  }

  package {'puppetserver':
    name    => 'puppetserver',
    ensure  => $server_version,
    require => File['/etc/hosts'],
  }

  exec { 'source':
    command   => 'source /root/.bash_profile',
    provider  => shell,
    subscribe => Package['puppetserver'],
  }

  service { 'puppetserver':
    ensure  => 'running',
    require => Package['puppetserver'],
  }
}


