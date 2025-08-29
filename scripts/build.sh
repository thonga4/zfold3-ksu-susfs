#!/usr/bin/env bash
set -euo pipefail
ROOT="$(pwd)"
source "$ROOT/work/kernel_path.env"
source "$ROOT/work/kernel_defconfig.env"
OUT="$KDIR/out"

# Toolchain: Clang 12 thường hợp với tree Samsung 5.4
export ARCH=arm64 SUBARCH=arm64 LLVM=1 LLVM_IAS=1
export PATH="$ROOT/llvm/bin:$PATH"
export CROSS_COMPILE=aarch64-linux-gnu-
export CROSS_COMPILE_COMPAT=arm-linux-gnueabi-

mkdir -p "$OUT"
make -C "$KDIR" O="$OUT" "$DEFCONFIG"
"$KDIR/scripts/kconfig/merge_config.sh" -m "$OUT/.config" "$ROOT/fragments/f926_su.fragment"
make -C "$KDIR" O="$OUT" olddefconfig

# Build kernel
make -C "$KDIR" O="$OUT" -j"$(nproc)" Image.gz-dtb dtbs

# Đóng gói AnyKernel3 (dạng zip flash qua TWRP)
cp "$OUT/arch/arm64/boot/Image.gz-dtb" anykernel3/ || true
pushd anykernel3 >/dev/null
zip -r9 "$ROOT/ZFold3_SukiSU_SUSFS.zip" . -x ".git/*" || true
popd >/dev/null

echo "::notice title=Build done::ZFold3_SukiSU_SUSFS.zip created"
