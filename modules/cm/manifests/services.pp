class cm::services($redisHost) {

  include 'redis'
  include 'mysql::server'
  include 'memcached'

  class {'socket-redis':
    redisHost => $redisHost,
    socketPorts => [8091, 8092, 8093, 8094],
  }
}
