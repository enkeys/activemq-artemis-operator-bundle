#!/usr/bin/env bash

mkdir -p tests/verify/{image,layer}
docker save $1 > tests/verify/image.tar
tar -xf tests/verify/image.tar -C tests/verify/image
find tests/verify/image -type f -name "layer.tar" -exec tar -xf {} -C tests/verify/layer \;
find tests/verify/layer -type f -name ".wh..wh..opq" -delete