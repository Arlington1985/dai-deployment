#!/bin/bash
set -euo pipefail
echo "===================================================================="
echo "Starting deployment of DAI with Docker"
echo "Major version: ${major_version}"
echo "Minor version: ${minor_version}"
echo "Cuda version:  ${cuda_version}"
echo "cuDNN version: ${cuDNN_version}"
echo "===================================================================="
echo "Installing docker and it's dependencies..."
sudo su ec2-user
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache
sudo yum -y install docker-ce --nobest
echo "Docker installed successfully"
echo "Starting docker service..."
sudo systemctl start docker
echo "Docker service was started"
TAR_FILE="/tmp/dai-docker-centos7-x86_64-${major_version}-${cuda_version}.tar.gz"
echo "Downloading docker image tar file to $TAR_FILE..."
curl "https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/rel-${major_version}-${minor_version}/x86_64-centos7/dai-docker-centos7-x86_64-${major_version}-${cuda_version}.tar.gz" --output $TAR_FILE
echo "Docker image downloaded successfully"
APP_FOLDER="/home/ec2-user/dai_rel_${major_version}-${cuda_version}"
echo "Creating application directory..."
mkdir $APP_FOLDER
cd $APP_FOLDER
mkdir data
mkdir log
mkdir license
mkdir tmp
mkdir config
cd ..
echo "Application directory was created"
echo "Loading downloaded docker image..."
sudo docker load < $TAR_FILE
echo "Docker image was loaded"
cd $APP_FOLDER

TMP_CONFIG_FILE="/tmp/config.toml"
if [ -f "$TMP_CONFIG_FILE" ]
then
  echo "Custom config file specified, default config.toml file will be replaced"
  cp $TMP_CONFIG_FILE config/config.toml
  CONFIG_FILE="/config/config.toml"
else
  echo "Custom config file doesn't specified, default config.toml file will be used"
  CONFIG_FILE="/etc/dai/config.toml"
fi

echo "Starting DAI docker container..."
sudo docker run \
    --pid=host \
    --init \
    --rm \
    --shm-size=256m \
    -u `id -u`:`id -g` \
    -p 12345:12345 \
    -v `pwd`/data:/data \
    -v `pwd`/log:/log \
    -v `pwd`/license:/license \
    -v `pwd`/tmp:/tmp \
    -v `pwd`/config:/config \
    -e DRIVERLESS_AI_CONFIG_FILE=$CONFIG_FILE \
    h2oai/dai-centos7-x86_64:${major_version}-cuda${cuda_version}
    