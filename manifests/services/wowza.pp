class cm::services::wowza(
  $path_userfiles,
  $rpc_url,
  $license = undef
 ) {

  class {'::wowza':
    license => $license,
  }

  class {'::wowza::app::cm':
    rpc_url => $rpc_url,
    archive_dir => "${path_userfiles}/streamChannels",
  }

}
