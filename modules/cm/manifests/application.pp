define cm::application ($path, $web = true, $domains = ['*'], $crons = undef) {

  if $web {
    apache2::vhost {$name:
      content => template('cm/application/vhost.conf'),
    }
  }
}
