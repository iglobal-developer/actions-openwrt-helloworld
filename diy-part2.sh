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
vsockVer=1.0
sed -i 's/root:::0:99999:7:::/root:$1$xN29oiry$bLifcqbeUbpgVVozEcDAS0:19274:0:99999:7:::/g' package/base-files/files/etc/shadow
sed -i 's/nobody:\*:0:0:99999:7:::/nobody:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

grep -v "DISTRIB_DESCRIPTION=" package/base-files/files/etc/openwrt_release > tmpFile && mv tmpFile package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION='VSocks V1.0'" >>package/base-files/files/etc/openwrt_release

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.11/g' package/base-files/files/bin/config_generate
rm -rf package/lean/luci-theme-argon
git clone https://github.com/iglobal-developer/luci-theme-argon.git package/lean/luci-theme-argon
rm -rf luci
git clone https://github.com/iglobal-developer/luci.git luci

grep -v "luciname    = " feeds/luci/modules/luci-base/luasrc/version.lua  > tmpFile  && mv tmpFile feeds/luci/modules/luci-base/luasrc/version.lua
echo "luciname    = VPROXY" >> feeds/luci/modules/luci-base/luasrc/version.lua
grep -v "luciversion = " feeds/luci/modules/luci-base/luasrc/version.lua  > tmpFile  && mv tmpFile feeds/luci/modules/luci-base/luasrc/version.lua
echo "luciversion = V1.0" >> feeds/luci/modules/luci-base/luasrc/version.lua

sed -i 's/luci/vsocks/g' feeds/luci/modules/luci-base/root/www/index.html
sed -i 's/LuCI - Lua/VSocks/g' feeds/luci/modules/luci-base/root/www/index.html
mv feeds/luci/modules/luci-base/htdocs/cgi-bin/luci feeds/luci/modules/luci-base/htdocs/cgi-bin/vsocks

sed -i 's/LuCI/VProxy/g' feeds/luci/modules/luci-base/src/mkversion.sh

git clone -b package "https://iglobal-developer:"$GITHUB_CHECKOUT"@github.com/iglobal-developer/vsocks.git" package/vsocks-app-vproxy
