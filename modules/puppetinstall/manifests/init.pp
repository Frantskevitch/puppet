class puppetinstall {

  if $::some == 'true' {
    include 'puppetinstall::serverinstall'
  }
  else {
    include 'puppetinstall::nodeinstall'
  }
}
