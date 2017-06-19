#!/bin/bash

function jv_pg_phs_takePictureAndOpenIt() {
    fswebcam -r ${jv_pg_phs_resolution} --no-banner -S ${jv_pg_phs_skipFrames} --jpeg ${jv_pg_phs_jpegQuality} ${jv_pg_phs_file}

    if [[ $? -eq 0 ]]; then
        say "$(jv_pg_phs_i18n PHOTO_TAKEN)"
        chromium-browser --kiosk ${jv_pg_phs_file} &
        return 0
    else
        say "$(jv_pg_phs_i18n PHOTO_FAILED)"
    fi

    return 1
}
