#!/usr/bin/env bash

# Loop forever in the background waiting for Vesktop to capture audio
while true; do
    # Check if Vesktop's recording stream exists in PipeWire
    if pw-cli dump short Node | grep -q "Vesktop RecordStream" 2>/dev/null; then
        # Create a loopback stream bridging system monitor output to Vesktop
        # if it isn't already active
        if ! pgrep -x "pw-loopback" > /dev/null; then
            pw-loopback -m "['FL', 'FR']" &
        fi
    fi
    sleep 3
done
