class cm::standalone ($appname, $path, $debug = false) {

  cm::application {$appname:
    path => $path,
    web => true,
    debug => $debug,
  }
  require 'redis'
  require 'mysql::server'
  require 'memcached'
  require 'socket-redis'
}
