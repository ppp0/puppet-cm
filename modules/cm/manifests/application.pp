define cm::application (
  $path,
  $web = false,
  $vhosts = {},
  $crons = undef,
  $debug = false
) {

  require 'composer'
  require 'php5'
  require 'php5::extension::apc'
  require 'php5::extension::mysql'
  require 'php5::extension::redis'
  require 'php5::extension::intl'
  require 'php5::extension::memcache'
  require 'php5::extension::gd'
  require 'php5::extension::imagick'
  require 'php5::extension::curl'
  require 'php5::extension::runkit'
  require 'php5::extension::stats'
  require 'php5::extension::svm'
  require 'php5::extension::mcrypt'
  require 'php5::extension::gearman'
  require 'php5::fpm'
  require 'uglify'
  require 'foreman::initd'
  require 'mysql::client'

  if $web {
    require 'cm::webserver'

    create_resources('cm::webserver::vhost', $vhosts, {path => $path, debug => $debug})
  }
}
