#!/usr/bin/env bash
# Pasang device tree PXLOS a52sxq ke dalam source tree Android.
#
# Pakai:
#   ./setup-tree.sh /path/ke/aosp
#
# Script akan membuat symlink:
#   <root>/device/samsung/a52sxq       -> <repo>/a52sxq
#   <root>/device/samsung/sm7325-common -> <repo>/sm7325-common
set -euo pipefail

ROOT="${1:-}"
if [ -z "$ROOT" ]; then
  echo "Pakai: $0 <android-source-root>"
  exit 1
fi

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$ROOT/device/samsung"

if [ ! -d "$ROOT/build/make" ]; then
  echo "!! $ROOT sepertinya bukan source tree Android (build/make tidak ada)"
  exit 1
fi

mkdir -p "$DEST"

for t in a52sxq sm7325-common; do
  if [ -e "$DEST/$t" ] && [ ! -L "$DEST/$t" ]; then
    echo "!! $DEST/$t sudah ada dan bukan symlink — dibiarkan"
    continue
  fi
  ln -sfn "$HERE/$t" "$DEST/$t"
  echo "== $DEST/$t -> $HERE/$t"
done

cat <<EOF

Selesai. Langkah berikutnya:

  source build/envsetup.sh
  lunch pxlos_a52sxq-userdebug     # setelah product makefile di-rename (lihat README TODO)

Kernel dan vendor blob tidak termasuk repo ini (lihat README).
EOF
