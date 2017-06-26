#!/bin/bash

function jv_pg_phs_takePhotoAndOpenIt() {
    jv_pg_phs_newFile
    jv_pg_phs_closePhoto

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
        jv_pg_phs_closePhoto
        say "$(jv_pg_phs_i18n PRINT_OK)"; return 0
    fi

    say "$(jv_pg_phs_i18n PRINT_FAILED)"; return 1
}

function jv_pg_phs_showPhoto() {
    chromium-browser --kiosk $(jv_pg_phs_getLastPhoto) > /dev/null 2>&1 & disown
    echo $! > ${jv_pg_op_browserLockFile}
}

function jv_pg_phs_closePhoto() {
    if [[ -e ${jv_pg_op_browserLockFile} ]] && kill -0 $(cat ${jv_pg_op_browserLockFile}) > /dev/null 2>&1
    then
        kill $(cat ${jv_pg_op_browserLockFile})
    fi
}

function jv_pg_phs_getLastPhoto() {
    ls -t ${jv_pg_phs_folder}/*.jpeg | head -n1
}

function jv_pg_phs_newFile() {
    touch ${jv_pg_phs_folder}/photo_$(date +%s).jpeg
}
