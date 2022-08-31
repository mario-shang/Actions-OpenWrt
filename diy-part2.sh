#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认网关IP
# sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# 清除旧版argon主题并拉取最新版
pushd feeds/luci/themes
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd

# 更改主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

echo '添加Clash'
git clone https://github.com/frainzy1477/luci-app-clash package/lean/luci-app-clash
echo 'CONFIG_PACKAGE_luci-app-clash=y' >> .config

echo '添加Passwall'
echo 'CONFIG_PACKAGE_luci-app-passwall=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_simple-obfs=n' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_v2ray-plugin=n' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook=n' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_kcptun=n' >> .config
echo 'CONFIG_PACKAGE_luci-i18n-passwall-zh-cn=y'  >> .config

echo '添加luci-app-vssr'
git clone https://github.com/jerrykuku/luci-app-vssr.git package/lean/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb
echo 'CONFIG_PACKAGE_luci-app-vssr=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-vssr_INCLUDE_V2ray=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Trojan=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ShadowsocksR_Server=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ShadowsocksR_Socks=y' >> .config
echo 'CONFIG_PACKAGE_luci-i18n-vssr-zh-cn=y'  >> .config

# 更改时区
# sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" ./package/base-files/files/bin/config_generate

# # Start Add Package ---------------------------------------------------------
# # Clone community packages to package/community
# mkdir package/community
# pushd package/community

# # Add mentohust & luci-app-mentohust.
# git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust
# git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk

# # Add ServerChan (need luci-app-wrtbwmon)
# git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# # Add OpenClash
# git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# # Add luci-app-argon-config
# git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config

# # Add luci-app-vssr (need lua-maxminddb)
# git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb
# git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# # Add luci-app-onliner (need luci-app-nlbwmon)
# git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# # Add luci-app-gowebdav
# git clone --depth=1 https://github.com/project-openwrt/openwrt-gowebdav

# # Add tmate
# git clone --depth=1 https://github.com/project-openwrt/openwrt-tmate

# # Add subconverter
# git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# # Add OpenAppFilter
# git clone --depth=1 https://github.com/destan19/OpenAppFilter

# # End Add Package  ---------------------------------------------------------
# popd