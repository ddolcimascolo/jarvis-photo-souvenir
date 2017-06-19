#!/bin/bash

jv_pg_phs_i18n() {
    case "${1}" in
        PHOTO_TAKEN) echo "Photo prise.";;
        PHOTO_FAILED) echo "Impossible de prendre la photo...";;
    esac
}
