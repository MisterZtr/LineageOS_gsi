#!/bin/bash

set -e

source="$(pwd)/LineageOS_gsi"
trebledroid="$source/patches/trebledroid"
trebledroid_staging="$source/patches/trebledroid-staging"
personal="$source/patches/personal"

apply_patch_dir() {
    local patch_dir=$1
    local patch_name=$2

    printf "\n ### APPLYING %s PATCHES ###\n" "$patch_name"
    sleep 1.0

    if [ ! -d "$patch_dir" ]; then
        printf "Directory %s not found, skipping...\n" "$patch_dir"
        return 0
    fi

    for path in $(cd "$patch_dir"; echo *); do
        tree="$(tr _ / <<<"$path" | sed -e 's;platform/;;g')"
        printf "\n| %s ###\n" "$path"

        [ "$tree" == build ] && tree=build/make
        [ "$tree" == testing ] && tree=platform_testing
        [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
        [ "$tree" == treble/app ] && tree=treble_app
        [ "$tree" == vendor/partner/gms ] && tree=vendor/partner_gms

        pushd "$tree" > /dev/null

        for patch in "$patch_dir"/"$path"/*.patch; do
            if patch -f -p1 --dry-run -R < "$patch" > /dev/null; then
                printf "### ALREADY APPLIED: %s \n" "$patch"
                continue
            fi

            if git apply --check "$patch"; then
                git am "$patch"
            elif patch -f -p1 --dry-run < "$patch" > /dev/null; then
                git am "$patch" || true
                patch -f -p1 < "$patch"
                git add -u
                git am --continue
            else
                printf "### FAILED APPLYING: %s \n" "$patch"
            fi
        done

        popd > /dev/null
    done
}

apply_patch_dir "$trebledroid" "TREBLEDROID"
apply_patch_dir "$trebledroid_staging" "TREBLEDROID STAGING"
apply_patch_dir "$personal" "PERSONAL"
