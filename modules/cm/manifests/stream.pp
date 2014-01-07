class cm::stream(
  $redisHost = '127.0.0.1',
  $ssl_cert = undef,
  $ssl_key = undef,
  $stream_members = ['localhost:8091', 'localhost:8092', 'localhost:8093', 'localhost:8094']
) {

  include 'nginx'

  $ssl = ($ssl_cert != undef) or ($ssl_key != undef)

  nginx::resource::vhost {'stream-server':
    ensure            => present,
    listen_port       => '8090',
    proxy             => 'http://backend-socketredis',
    ssl               => $ssl,
    ssl_port          => '8090',
    ssl_cert          => $ssl_cert,
    ssl_key           => $ssl_key,
    location_cfg_append => [
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_set_header Host $host;',
      'proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;',
      'proxy_http_version 1.1;',
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";',
      'proxy_buffering off;',
    ],
  }

  nginx::resource::upstream {'backend-socketredis':
    ensure  => present,
    members => $stream_members,
    upstream_cfg_append => [
      'ip_hash;',
    ],
  }

  class {'socket-redis':
    redisHost => $redisHost,
    socketPorts => [8091, 8092, 8093, 8094],
  }
}
