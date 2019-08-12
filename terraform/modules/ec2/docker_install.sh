#!/bin/bash
sudo su ec2-user
set -euxo pipefail
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache
sudo yum -y install docker-ce --nobest
sudo systemctl start docker
FILE="/tmp/dai-docker-centos7-x86_64-1.7.0-10.0.tar.gz"
if test -f $FILE; then
  echo "$FILE exist"
else
  curl https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/rel-1.7.0-214/x86_64-centos7/dai-docker-centos7-x86_64-1.7.0-10.0.tar.gz --output $FILE
fi
FOLDER="/home/ec2-user/dai_rel_1.7.0-10.0"
if test -d $FOLDER; then
  echo "$FOLDER exist"
else
  mkdir $FOLDER
  cd $FOLDER
  mkdir data
  mkdir log
  mkdir license
  mkdir tmp
  cd ..
fi
count=$(sudo docker images h2oai/dai-centos7-x86_64 | wc -l)
if [ $count -gt 1 ]; then
  echo "image exist"
else
  sudo docker load < $FILE
fi
cd $FOLDER
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
    h2oai/dai-centos7-x86_64:1.7.0-cuda10.0
 touch /tmp/finished-user-data 