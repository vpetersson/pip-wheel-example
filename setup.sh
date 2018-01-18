#!/bin/bash

echo -e "\nCreate a network...\n"
docker network create wheelhouse

echo -e "\nBuild the containers...\n"
docker build -t wheel-build -f Dockerfile.build .
docker build -t wheel-install -f Dockerfile.install .

echo -e "\nRun the wheelhouse server...\n"
docker run -d \
    --name wheelhouse \
    --network wheelhouse \
    wheel-build

sleep 2

echo -e '\nVerify that we can access one of the wheels...\n'
docker exec -ti wheelhouse curl -I http://wheelhouse/zencoder-0.6.5-py2-none-any.whl

echo -e "\nNow let's try installing using the wheel...\n"
docker run --rm \
    --name wheelhouse-consumer \
    --network wheelhouse \
    wheel-install

echo -e "\nThe Nginx logs...\n"
docker logs wheelhouse

echo -e '\nCleaup\n'
docker network rm wheelhouse
docker kill wheelhouse
docker rm wheelhouse wheelhouse-consumer >/dev/null
