class cm::services {

  include 'redis'
  include 'mysql::server'
  include 'memcached'
  include 'elasticsearch'
  include 'gearmand::server'
  include 'cm::stream'
}
