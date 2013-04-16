define util::mount (
  $device,
  $mp           = undef,
  $options      = 'defaults,bg,intr',
  $noauto       = false,
  $readonly     = false,
  $ensure       = mounted
) { 
  if ( $mp == undef ) {
    $mymp = $title
  }
  else {
    $mymp = $mp
  }

  if ( $noauto ) {
    $opt1 = "${options},noauto"
  }
  else {
    $opt1 = $options
  }

  if ( $readonly ) {
    $opt2 = "ro,${opt1}"
  }
  else {
    $opt2 = "rw,${opt1}"
  }

  # O mkdir recebe false como defaults de user e group
  if ( $ensure != 'absent')  {
    if ( !defined( Mkdir[$mymp] ) ) {
       mkdir { $mymp: }
    }
    $req = Mkdir[$mymp]
  }
  else {
    $req = undef
  }
  mount { $mymp:
    ensure      => $ensure,
    device      => $device,
    fstype      => 'nfs',
    options     => $opt2,
    remounts    => true,
    require     => $req,
    ;
  }
}
