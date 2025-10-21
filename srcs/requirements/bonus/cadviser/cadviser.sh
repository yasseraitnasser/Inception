#!/bin/sh

wget https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 -O cadvisor

chmod +x cadvisor

exec ./cadvisor
