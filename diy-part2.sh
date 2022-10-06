#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
sed -i 's/nobody:\*:0:0:99999:7:::/nobody:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

grep -v "DISTRIB_DESCRIPTION=" package/base-files/files/etc/openwrt_release > tmpFile && mv tmpFile package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION='VSocks V1.0'" >>package/base-files/files/etc/openwrt_release
grep -v "luciname    = " package/base-files/files/usr/lib/lua/luci/version.lua  > tmpFile  && mv tmpFile package/base-files/files/usr/lib/lua/luci/version.lua
echo "luciname    = VPROXY" >> package/base-files/files/usr/lib/lua/luci/version.lua
grep -v "luciversion = " package/base-files/files/usr/lib/lua/luci/version.lua  > tmpFile  && mv tmpFile package/base-files/files/usr/lib/lua/luci/version.lua
echo "luciversion = V1.0" >> package/base-files/files/usr/lib/lua/luci/version.lua

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.11/g' package/base-files/files/bin/config_generate
rm -rf package/lean/luci-theme-argon
git clone https://github.com/iglobal-developer/luci-theme-argon.git package/lean/luci-theme-argon
rm -rf package/luci
git clone https://github.com/iglobal-developer/luci.git package/luci
git clone -b master --depth 1 https://github.com/kuoruan/openwrt-upx.git package/openwrt-upx
git clone https://github.com/iglobal-developer/openwrt-v2ray.git package/v2ray-core
git clone -b package "https://iglobal-developer:"$GITHUB_CHECKOUT"@github.com/iglobal-developer/vsocks.git" package/vsocks-app-vproxy
