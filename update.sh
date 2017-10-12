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
git checkout ${commit}
rm -rf vendor
cp $GOPATH/src/github.com/lukasmacko/glideUpdater/glide.yaml .
glide install --strip-vendor
rm -rf .git

cd ..

tar -cf data.tar ${project} 
cat > Dockerfile <<- "EOF"
FROM alpine
RUN mkdir updated
COPY data.tar updated/
EOF


tag=`date +%m%d%H%M%S`
IMG_NAME=lmacko1992/glideupd:${tag}

docker build -t ${IMG_NAME} .
echo ${IMG_NAME} > ~/image

echo "--------------------------------"
echo "docker pull ${IMG_NAME}"
echo "id=\$(docker create ${IMG_NAME})"
echo "docker cp \$id:/updated/data.tar ."
echo "docker rm -v \$id"


