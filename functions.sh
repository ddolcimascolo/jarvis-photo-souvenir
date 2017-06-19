#!/bin/bash

function jv_pg_phs_takePhotoAndOpenIt() {
    jv_pg_phs_newFile
    fswebcam -q -r ${jv_pg_phs_resolution} --no-banner -S ${jv_pg_phs_skipFrames} --jpeg ${jv_pg_phs_jpegQuality} $(jv_pg_phs_getLastPhoto)

    if [[ $? -eq 0 ]]; then
        jv_pg_phs_showPhoto

        say "$(jv_pg_phs_i18n PHOTO_OK)"; return 0
    fi

    say "$(jv_pg_phs_i18n PHOTO_FAILED)"; return 1
}

function jv_pg_phs_printPhoto() {
    lpr -P ${jv_pg_phs_printer} $(jv_pg_phs_getLastPhoto)

    if [[ $? -eq 0 ]]; then
        say "$(jv_pg_phs_i18n PRINT_OK)"; return 0
    fi

    say "$(jv_pg_phs_i18n PRINT_FAILED)"; return 1
}

function jv_pg_phs_closePhoto() {
    killall chromium-browser
}

function jv_pg_phs_showPhoto() {
    chromium-browser --kiosk $(jv_pg_phs_getLastPhoto) &
}

function jv_pg_phs_getLastPhoto() {
    ls -t ${jv_pg_phs_folder}/*.jpeg | head -n1
}

function jv_pg_phs_newFile() {
    touch ${jv_pg_phs_folder}/photo_$(date +%s).jpeg
}
