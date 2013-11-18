define cm::application ($path, $web = true, $domains = ['*'], $crons = undef, $debug = false) {

  require 'composer'

  if $web {
    require 'cm::httpd'

    apache2::vhost {$name:
      content => template('cm/application/vhost.conf'),
    }
  }
}
