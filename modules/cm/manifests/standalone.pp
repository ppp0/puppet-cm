class cm::standalone ($appname, $path) {

  cm::application {$appname:
    path => $path,
    web => true,
  }
  require 'redis'
  require 'mysql::server'
  require 'memcached'
  require 'socket-redis'
}
