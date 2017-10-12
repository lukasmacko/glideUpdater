#!/bin/bash
config=$(<conf)
clonePath=$(echo $config | cut -d ' ' -f 1)
project=$(echo $config | cut -d ' ' -f 2)
repo=$(echo $config | cut -d ' ' -f 3)
commit=$(echo $config | cut -d ' ' -f 4)

cd $GOPATH/src
mkdir -p ${clonePath}
cd ${clonePath}
git clone ${repo}
cd ${project}
rm -rf vendor
cp $GOPATH/src/github.com/lukasmacko/glideUpdater/glide.yaml .
glide install --strip-vedor

cd ..
tar -cvf data.tar ${project}
cat > Dockerfile <<- "EOF"
FROM alpine
COPY data.tar
EOF


tag=`date +%m%d%H%M%S`

docker build -t lmacko1992/glideupd:${tag} .

echo "docker pull lmacko1992/glideupd:${tag}"


