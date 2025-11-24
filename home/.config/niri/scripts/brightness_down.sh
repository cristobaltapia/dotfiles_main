#!/usr/bin/env bash
light -U 5 && light -G | cut -d'.' -f1 > $XDG_RUNTIME_DIR/wob.sock
