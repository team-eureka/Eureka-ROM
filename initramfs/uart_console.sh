#!/bin/sh

# Lets start a console shell over uart
TEMPFILE=/tmp/.uartconsole

# Sleep so other startup services can complete
sleep 12

if ! /bin/exists ${TEMPFILE}; then
    touch ${TEMPFILE}
    /bin/busybox sh </dev/ttyS0 >/dev/ttyS0 2>&1
    rm ${TEMPFILE}
fi