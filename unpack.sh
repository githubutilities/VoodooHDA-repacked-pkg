#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

cd Contents/VoodooHDAMAV.pkg

mkdir payload_unpack

cp Payload payload_unpack

cd payload_unpack

cat ./Payload | gunzip --decompress --to-stdout | cpio -i

rm Payload
