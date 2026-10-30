#!/bin/bash
# jenga.sh — jenga mkusanyaji wa Swa kutoka baiti za mkono hadi bin/swa
#
#   kwanza.bin (baiti za mkono) -> mbegu -> stage1 -> bin/swa
#
# bin/swa ni kizazi cha pili: stage1 iliyojijenga yenyewe, hivyo ina
# uboreshaji wote wa uzalishaji.swa (mbegu iliyogandishwa haina).
# Hakuna gcc, ld, clang wala libc -- bash na syscalls pekee.
set -eu
cd "$(dirname "$0")/.." || exit 1

TMP="$(mktemp -d /tmp/swa-jenga-XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

bash gharama/jenga-kwanza.sh > /dev/null
MBEGU="/tmp/mbegu2.bin"

cat msingi/maktaba/kumbukumbu.swa msingi/maktaba/mfuatano.swa \
    msingi/maktaba/faili.swa gharama/msuluhishi.swa > "$TMP/msuluhishi.swa"
"$MBEGU" --exe "$TMP/msuluhishi.swa" > "$TMP/msuluhishi"
chmod +x "$TMP/msuluhishi"
"$TMP/msuluhishi" msingi/mkusanyaji/stage1.swa > "$TMP/zima.swa"

"$MBEGU" --exe "$TMP/zima.swa" > "$TMP/stage1"
chmod +x "$TMP/stage1"

mkdir -p bin
"$TMP/stage1" --exe "$TMP/zima.swa" > bin/swa
chmod +x bin/swa
echo "bin/swa iko tayari"
