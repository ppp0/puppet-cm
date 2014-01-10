class cm::services {

  include 'redis'
  include 'mysql::server'
  include 'memcached'
  include 'cm::stream'
}
