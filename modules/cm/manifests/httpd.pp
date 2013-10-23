class cm::httpd {

  require 'apache2'
  require 'apache2::mod::rewrite'
  require 'php5::apache2'
  require 'php5::extension::apc'
  require 'php5::extension::mysql'
  require 'php5::extension::redis'
  require 'php5::extension::intl'
  require 'php5::extension::memcache'
  require 'uglify'
}
