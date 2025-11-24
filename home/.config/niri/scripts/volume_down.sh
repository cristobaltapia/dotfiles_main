#!/usr/bin/env bash
wpctl set-volume @DEFAULT_SINK@ 0.02- && wpctl get-volume @DEFAULT_SINK@ | awk '{print $2*100}' > $XDG_RUNTIME_DIR/wob.sock
