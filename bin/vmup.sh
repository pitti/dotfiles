#!/bin/bash

CMD=$(basename ${0})

HOST=wilkinson
MACHINE=wojewodski

exec ssh ${HOST} "nohup /opt/site/bin/${CMD} ${MACHINE} >/dev/null &"

