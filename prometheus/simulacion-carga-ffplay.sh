#!/bin/bash

STREAM_URL="rtmp://192.168.49.2:31031/live/test"
CLIENTS=5  # Numero de accesos

for i in $(seq 1 $CLIENTS); do
  echo "Cliente $i...visualizando"
  ffplay -loglevel error -nostats -autoexit "$STREAM_URL" &
  sleep 1  # Delay contra saturacion
done

wait
echo "Todos los clientes han terminado."
