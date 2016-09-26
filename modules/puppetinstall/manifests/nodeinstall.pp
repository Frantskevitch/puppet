# This class install puppet-agent
class puppetinstall::nodeinstall(
  $agent_version = '1.7.0-1.el7',
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

  host { 'puppet':
    ip           => '192.168.56.50',
    host_aliases => 'puppet.com',
    }

  package { 'puppet-agent':
    name    => 'puppet-agent',
    ensure  => $agent_version,
    require => Yumrepo['puppetlabs-pc1'],
  }

  exec { 'source':
    command   => 'source /root/.bash_profile',
    provider  => shell,
    subscribe => Package['puppet-agent'],
  }

  service { 'puppet':
    ensure  => 'running',
    require => Package['puppet-agent'],
  }
}
