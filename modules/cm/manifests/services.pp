class cm::services($redisHost = '10.10.10.100') {

  include 'redis'
  include 'mysql::server'
  include 'memcached'
  include 'cm::stream'

  class {'socket-redis':
    redisHost => $redisHost,
    socketPorts => [8091, 8092, 8093, 8094],
  }
}
