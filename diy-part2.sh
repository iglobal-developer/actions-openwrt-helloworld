#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.11/g' package/base-files/files/bin/config_generate
rm -rf package/lean/luci-theme-argon
git clone https://github.com/iglobal-developer/luci-theme-argon.git package/lean/luci-theme-argon
rm -rf package/luci
git clone https://github.com/iglobal-developer/luci.git package/luci
git clone https://github.com/iglobal-developer/openwrt-v2ray.git package/v2ray-core
git clone "https://"$GITHUB_TOKEN"@github.com/iglobal-developer/vsocks.git" package/vsocks-app-vproxy
