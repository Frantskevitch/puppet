class puppetinstall {

if $::hostname == 'puppet'  {include 'puppetinstall::serverinstall'}
else {include 'puppetinstall::nodeinstall'}
}
