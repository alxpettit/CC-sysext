#!/usr/bin/env bash
multimc_install_dir=/home/$USER/.local/share/multimc/
computercraft_storage_path=computercraft/computer/
trash_dir=/home/$USER/.trash

mkdir -p "$trash_dir"

function copy_to_save() {
    instance_name=$1
    save_name=$2
    multimc_instance_path=instances/$instance_name/.minecraft/
    minecraft_save_path=saves/$save_name/

    target=$multimc_install_dir$multimc_instance_path$minecraft_save_path$computercraft_storage_path

    echo "Target path found: '$target'"
    for computer in $target*; do
        rsync -a "src/sysext" "$computer/" --delete --backup-dir="$trash_dir" &
        cp -a "src/startup.lua" "$computer/" & 
    done
}

copy_to_save almost_vanilla LuaLand
copy_to_save almost_vanilla AlmostVanilla
