define cm::webserver::vhost(
  $path,
  $ssl_cert,
  $ssl_key,
  $aliases = [],
  $cdn_origin = undef
 ) {

  $hostnames = concat([$name], $aliases)

  nginx::resource::vhost{"${name}-http":
    listen_port => 80,
    server_name => $hostnames,
    location_cfg_append => [
      'return 301 https://$host$request_uri;',
    ],
  }

  nginx::resource::vhost {"${name}-https":
    server_name => $hostnames,
    ssl => true,
    ssl_port => 443,
    listen_port => 443,
    ssl_cert => $ssl_cert,
    ssl_key => $ssl_key,
    location_cfg_append => [
      'include fastcgi_params;',
      "fastcgi_param SCRIPT_FILENAME ${path}/public/index.php;",
      'fastcgi_keep_conn on;',
      "fastcgi_pass fastcgi-backend;",
      'error_page 502 =503 /maintenance;',
    ],
  }

  nginx::resource::location{"${name}-fpm-status":
    vhost => "${name}-https",
    location => '/fpm-status',
    location_cfg_append => [
      'deny all;',
    ],
  }

  nginx::resource::location{"${name}-maintenance":
    vhost => "${name}-https",
    location => '/maintenance',
    www_root => "${path}/public",
    try_files => ['/maintenance.html', 'something-nonexistent'],
  }

  if ($cdn_origin) {
    nginx::resource::vhost{"${name}-origin":
      listen_port => 80,
      server_name => [$cdn_origin],
      vhost_cfg_prepend => [
       'expires 1y;',
       'gzip on;',
       'gzip_min_length 1000;',
       'gzip_types application/x-javascript text/css text/plain application/xml;',
      ],
      location_cfg_append => [
        'deny all;',
      ],
    }

    nginx::resource::location{"${name}-origin-upstream":
      location => '~* ^/(vendor-css|vendor-js|library-css|library-js|layout)/',
      vhost => "${name}-origin",
      location_cfg_append => [
        'include fastcgi_params;',
        "fastcgi_param SCRIPT_FILENAME ${path}/public/index.php;",
        'fastcgi_keep_conn on;',
        "fastcgi_pass fastcgi-backend;",
      ],
    }

    nginx::resource::location{"${name}-origin-static":
      location => '/static',
      vhost => "${name}-origin",
      www_root => "${path}/public",
      location_cfg_append => [
        'add_header	Access-Control-Allow-Origin	*;',
      ],
    }

    nginx::resource::location{"${name}-origin-userfiles":
      location => '/userfiles',
      www_root => "${path}/public",
      vhost => "${name}-origin",
    }
  }
}
