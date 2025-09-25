#!/bin/bash

STREAM_URL="rtmp://192.168.49.2:31031/live/test"
CLIENTS=5

for i in $(seq 1 $CLIENTS); do
  echo "Lanzando cliente $i..."
  cvlc -q --play-and-exit "$STREAM_URL" &
  sleep 1
done

wait
echo "Todos los clientes han terminado."
