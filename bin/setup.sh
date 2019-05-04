#!/usr/bin/env bash
  
set -ex

export N_PREFIX=$HOME/.node
export PATH="${HOME}/.node/bin:${HOME}/.local/bin:${HOME}/.npm-packages/bin:$PATH"

sudo sh -c 'echo 127.0.1.1 $(hostname) >> /etc/hosts'

sudo add-apt-repository ppa:ubuntugis/ppa -y && sudo apt-get update -y
sudo apt-get install -y osmium-tool docker-compose rename python3-pip make gcc g++ libsqlite3-dev python3.6-dev gdal-bin nodejs npm libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev build-essential -y

cd $HOME

git clone https://github.com/mapbox/tippecanoe.git
cd tippecanoe/
make -j
sudo make install

cd $HOME
sudo rm -fr $HOME/tippecanoe

# mb-util をインストール
git clone git://github.com/mapbox/mbutil.git
cd mbutil
sudo python3 setup.py install

cd $HOME
sudo rm -fr $HOME/mbutil

pip3 install requests --upgrade --user # It is needed to avoid conflict.
pip3 install awscli --upgrade --user

echo 'prefix = ${HOME}/.npm-packages' > $HOME/.npmrc

cat << EOL > ~/.bash_profile
export N_PREFIX=$HOME/.node
export PATH="${HOME}/.node/bin:${HOME}/.local/bin:${HOME}/.npm-packages/bin:$PATH"
EOL

npm install -g n
${HOME}/.npm-packages/bin/n lts
${HOME}/.node/bin/npm install -g tileserver-gl
