#!/bin/bash

jv_pg_phs_i18n() {
    case "${1}" in
        PHOTO_OK) echo "Photo prise.";;
        PHOTO_FAILED) echo "Impossible de prendre la photo...";;
        PRINT_OK) echo "Impression en cours...";;
        PRINT_FAILED) echo "Impossible d'imprimer la photo...";;
    esac
}
