#!/usr/bin/env bash
set -euo pipefail
ROOT="$(pwd)"
source "$ROOT/work/kernel_path.env"
cd "$KDIR"

# Khởi tạo git để dùng git am
git init
git add -A && git commit -m base >/dev/null

# 1) Áp SukiSU Ultra (nhánh 5.4)
if compgen -G "$ROOT/patches/suki/*.patch" > /dev/null; then
  echo "[*] Applying SukiSU Ultra patches..."
  git am "$ROOT/patches/suki/"*.patch
else
  echo "[!] Chưa có patch SukiSU trong patches/suki"
fi

# 2) Áp SUSFS (nhánh 5.4)
if compgen -G "$ROOT/patches/susfs/*.patch" > /dev/null; then
  echo "[*] Applying SUSFS patches..."
  git am "$ROOT/patches/susfs/"*.patch
else
  echo "[!] Chưa có patch SUSFS trong patches/susfs"
fi
