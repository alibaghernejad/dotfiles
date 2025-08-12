#!/bin/bash

# Check the current state of the microphone
MIC_STATE=$(amixer get Capture | grep '\[on\]')

if [ -n "$MIC_STATE" ]; then
# If the microphone is on, turn it off
amixer set Capture nocap
notify-send "Microphone" "Microphone muted"
else
# If the microphone is off, turn it on
amixer set Capture cap
notify-send "Microphone" "Microphone unmuted"
fi
