#!/bin/bash

sudo add-apt-repository -y universe
sudo apt update
sudo apt install --no-install-recommends -y libx11-6 libxrender1 libxcb1 libcairo2 \
	tcl8.6 tk8.6 flex libxpm4 libjpeg-dev xterm vim-gtk3 tcl-tclreadline \
	xfonts-base xfonts-75dpi xfonts-100dpi xfonts-scalable \
	libglu1-mesa zlib1g libncurses6 \
	libxaw7 libreadline8t64 libgomp1 python3-pip python3-venv \
	libgtk-3-0t64 gettext klayout

cat << EOF > ~/.spiceinit
set ngbehavior=hsa
set ng_nomodcheck
EOF

mkdir -p ~/.xschem/simulations
cp ~/.spiceinit ~/.xschem/simulations

python3 -m venv ~/venv
~/venv/bin/pip3 install ciel
~/venv/bin/ciel enable --pdk-family sky130 --pdk-root ~/pdk 026824c7969ce6f4fc9678e6ca04b0a06a596c4b
~/venv/bin/ciel enable --pdk-family gf180mcu --pdk-root ~/pdk 1689ac3f2dc763876eaf967227c7dfe831b031ae

mkdir -p ~/design
PDK_ROOT=~/pdk
PDK=sky130A

cat << EOF > ~/design/xschemrc
if {[info exists env(PDK_ROOT)] && $env(PDK_ROOT) ne ""} {
    source $env(PDK_ROOT)/$env(PDK)/libs.tech/xschem/xschemrc
}
EOF

#export VIRTUAL_ENV=$HOME/venv
#export KLAYOUT_PYTHONPATH=$VIRTUAL_ENV/lib/python3.12/site-packages
#export PYTHONNOUSERSITE=1

sudo tar -xJf ./eda.tar.xz -C /usr/local


