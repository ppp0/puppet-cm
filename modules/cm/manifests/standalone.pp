class cm::standalone ($appname, $path) {

  cm::application {$appname:
    path => $path,
    web => true,
  }
  require 'redis', 'mysql::server', 'memcached'
}
