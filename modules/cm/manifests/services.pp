class cm::services {

  include 'redis'
  include 'mysql::server'
  include 'memcached'
  include 'socket-redis'
}
