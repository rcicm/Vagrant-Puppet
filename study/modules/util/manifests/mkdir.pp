define util::mkdir(
    $path       = false,
    $usuario    = false,
    $grupo      = false,
    $mode       = false
) {

    $dir_path = $path ? { false => $name, default => $path }
    exec { "mkdir -p ${dir_path}":
        # 'mkdir -p dir' is faster than test
        onlyif  => "test ! -d ${dir_path}",
    }

    if ( $grupo == false or $grupo == '' ) {
        $group = $usuario
    }
    else {
        $group = $grupo
    }

    File {
        ensure      => directory,
        require     => Exec["mkdir -p ${dir_path}"],
    }
    if ( $usuario == false or $usuario == "" ) {
        if ( $mode == false ) {
            if ! defined(File["${dir_path}"]) {
                file { "$dir_path": }
            }
        }
        else {
            if ! defined(File["${dir_path}"]) {
                file { "$dir_path": mode => $mode, }
            }
        }
    }
    else {
        # Force user and grup
        if ( $mode == false ) {
            if ! defined(File["${dir_path}"]) {
                file { "$dir_path": owner => $usuario, group => $group, }
            }
        }
        else {
            if ! defined(File["${dir_path}"]) {
                file { "$dir_path": mode => $mode, owner => $usuario, group => $group, }
            }
        }
    }
}
