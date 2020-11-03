#!/usr/bin/env bash

mkdir -p tests/verify/{image,layer}
docker save $1 > tests/verify/image.tar
tar -xf tests/verify/image.tar -C tests/verify/image
find tests/verify/image -type f -name "layer.tar" -exec tar -xf {} -C tests/verify/layer \;
find tests/verify/layer -type f -name ".wh..wh..opq" -delete

# Predicable image config name
CONFIG_FILE="tests/verify/image/$(grep -o '"Config":"[^"]*' tests/verify/image/manifest.json | grep -o '[^"]*$')"
cp $CONFIG_FILE tests/verify/image/pre_config.json

# Encode unicode chars
echo -e $(cat tests/verify/image/pre_config.json) > tests/verify/image/config.json
rm tests/verify/image/pre_config.json
