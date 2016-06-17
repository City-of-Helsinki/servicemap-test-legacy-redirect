#!/bin/bash

FAILCOUNT=0
PROTOCOL=http

function test_status_code () {
    URL="$PROTOCOL://$1"
    CODE=$(curl -w "%{http_code}\n" -I -s -S "$URL" -o /dev/null)
    if [ "$CODE" != "301" ]; then
        cat <<EOF
------------------------------------------------------
Redirect has to be 301. Received $CODE for $URL.
EOF
        let "FAILCOUNT++"
    fi
}

function print_error_count () {
    cat <<EOF
------------------------------------------------------
$FAILCOUNT failing tests.

EOF
}

function redirect_url () {
    URL=$1
    curl -w "%{redirect_url}\n" -I -s -S "$PROTOCOL://$URL" --max-redirs 1 -o /dev/null
}

function asr () {
    # asr == assert redirect
    SRC=$1
    DEST="$PROTOCOL://$2"

    test_status_code $SRC

    REAL_DEST=$(redirect_url $SRC)
    if [ "$REAL_DEST" != "$DEST" ]; then
        cat <<EOF
------------------------------------------------------
$SRC being the source,
$DEST was expected,
$REAL_DEST received.
EOF
    let "FAILCOUNT++"
    fi
}
