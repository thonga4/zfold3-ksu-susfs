#!/usr/bin/env bash
set -euo pipefail

OSRC_ZIP_URL="${OSRC_ZIP_URL:?Set OSRC_ZIP_URL to Samsung opensource zip URL}"
DEFCONFIG="${DEFCONFIG:?Set DEFCONFIG to device defconfig (e.g. vendor/q2q_defconfig)}"

WORKDIR="$(pwd)/work"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

echo "[*] Download kernel source..."
curl -L "$OSRC_ZIP_URL" -o osrc.zip
mkdir -p src && bsdtar -xvf osrc.zip -C src

# Tìm thư mục kernel bên trong zip
cd src
KDIR="$(find . -maxdepth 3 -type d -name '*kernel*' | head -n1)"
[ -z "$KDIR" ] && { echo "Kernel dir not found"; exit 1; }

# Lưu lại để bước sau dùng
echo "KDIR=$(realpath "$KDIR")" > ../kernel_path.env
echo "DEFCONFIG=$DEFCONFIG" > ../kernel_defconfig.env
