#!/bin/bash

# Extract the device ID given to the U-PHONE UFO202 by the OS.
DEVICE_ID="$(arecord -l | awk '/^card/ {gsub(/:/,"",$2); print $2; exit}')"


# Launch ffmpeg to capture audio from the specified ALSA device
# and stream it to the Icecast server.
exec ffmpeg -f alsa -i hw:$DEVICE_ID,0 \
  -ac 2 -ar 44100 \
  -c:a libmp3lame -b:a 320k \
  -f mp3 my-icecast://source:hackme@icecast:8000/rapi.mp3