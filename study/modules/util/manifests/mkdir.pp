define util::mkdir(
    $path       = false,
    $usuario    = false,
    $grupo      = false,
    $mode       = false
) {

    $dir_path = $path ? { false => $name, default => $path }
    exec { "mkdir -p ${dir_path}":
        # Rodar o mkdir -p direto é mais rápido que testar antes, e ainda
        # permite que o File{} de depois rode como deveria, mas acaba gerando
        # mais logs de puppet do que o necessário.
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
        # Não vou forçar um usuário...
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
        # Força usuario e grupo
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
