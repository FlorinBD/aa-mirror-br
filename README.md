# 🛠️ Buildroot for [aa-mirror-rs](https://github.com/FlorinBD/aa-mirror-rs)

This repository contains the build system (based on Buildroot) used for building [aa-mirror](https://github.com/FlorinBD/aa-mirror-rs) images.

Originally based on [buildroot](https://github.com/aa-proxy/buildroot) but includes also other packages like: ADB and FFMPEG
## 🚀 Quick Start (Example: Radxa 03W)

```bash
git clone --recurse-submodules https://github.com/FlorinBD/rpi_radxa_buildroot
cd buildroot
./docker-dev build
./docker-dev radxa03w
```

## 🐳 Interactive development (container shell)
If you want more control, you can enter an interactive shell inside the development container:

```
./docker-dev shell
```
Once inside, you can manually run builds like this:

```
./build-image.sh radxa03w
```
Useful for testing, debugging, or tweaking the environment without restarting the whole process.

## 📦 Available Configurations
All supported board/device configurations can be found here:  
👉 [external/configs](https://github.com/aa-proxy/buildroot/tree/main/external/configs) on GitHub

## 💾 Output Image
After a successful build, the final SD card image (for above example) will be located at:

```
buildroot/output/radxa03w/images/sdcard.img
```
You can flash this image directly to an SD card using dd, [balenaEtcher](https://etcher.balena.io/) or whatever flash tool you like.
## 📦 git commands to make .sh files executable from windows and submodules update
```bash
git config core.fileMode false

git add --chmod=+x -- build-image.sh
git add --chmod=+x -- docker-dev.sh
git add --chmod=+x -- external\board\aaw2b\post-image.sh
git add --chmod=+x -- external\board\aaw2b\rootfs_overlay\etc\init.d\S10rtk_hciattach
git add --chmod=+x -- external\board\common\add_tty1.sh
git add --chmod=+x -- external\board\common\add_usb_serial.sh
git add --chmod=+x -- external\board\common\generate-issue.sh
git add --chmod=+x -- external\board\common\post-build.sh
git add --chmod=+x -- external\board\qemu\post-build.sh
git add --chmod=+x -- external\board\qemu\post-image.sh
git add --chmod=+x -- external\board\radxa03w\post-image.sh
git add --chmod=+x -- external\board\radxa03w\rootfs_overlay\etc\init.d\S00modules
git add --chmod=+x -- external\board\radxa03w\rootfs_overlay\etc\init.d\S27rfkill
git add --chmod=+x -- external\board\rpi\post-build.sh
git add --chmod=+x -- external\board\rpi\post-image.sh
git add --chmod=+x -- external\board\rpi\rootfs_overlay\etc\init.d\S00modules
git add --chmod=+x -- external\package\aic8800\S25btattach
git add --chmod=+x -- external\rootfs_overlay\etc\default\dropbear
git add --chmod=+x -- external\rootfs_overlay\etc\init.d\rcS
git add --chmod=+x -- external\rootfs_overlay\etc\init.d\S92usb_gadget
git add --chmod=+x -- external\rootfs_overlay\etc\init.d\S39cfg-prepare
git add --chmod=+x -- external\rootfs_overlay\etc\init.d\S40eth_config
git add --chmod=+x -- external\rootfs_overlay\etc\overlay_init
git add --chmod=+x -- external\rootfs_overlay\etc\S92usb_gadget.in
git add --chmod=+x -- external\scripts\defconfig_merger.sh
git add --chmod=+x -- tools\aaw\flash.sh
git add --chmod=+x -- tools\aaw\rkdownload.sh
git add --chmod=+x -- tools\aaw\upgrade_tool


git submodule add https://github.com/buildroot/buildroot
git commit -a -m "Make file executable"
git push https://mail%40yahoo.com:key@github.com/FlorinBD/rpi_radxa_buildroot.git main
```
