#!/usr/bin/env bash

ROOT=$(pwd)
RELEASE=$ROOT/app/build/outputs/apk/common/release
OUTPUT=$ROOT/output
KS=$ROOT/extra/debug.jks
KSP=$ROOT/extra/debug_ks_pass

pip install requests
sudo apt install apksigner -y

$ROOT/gradlew :app:assembleRelease

mkdir $OUTPUT

for i in $(find $RELEASE -name *.apk -print); do
   in=$i
   out="$OUTPUT/$(echo $(basename $i) | sed "s/un//g")"
   apksigner sign -v --ks $KS --in $in --out $out --ks-pass file:$KSP
done

$ROOT/extra/esc 18749089524 12345678x $OUTPUT
