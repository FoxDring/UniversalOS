#!/bin/bash
#============================================================
# https://github.com/FoxDring/flippy-openwrt-actions
# File name: diy-part3.sh
# Description: OpenWrt DIY script part 3 (After Update feeds)
# Lisence: MIT
# Author: Dring
# Blog: https://github.com/FoxDring
#============================================================




# 【参考各种修改写法】：
# https://github.com/quanjindeng/Actions_OpenWrt-Amlogic/blob/main/diy-part2-istore.sh
# https://github.com/breakings/OpenWrt/blob/main/diy-part2.sh


# Uncomment a feed source
sed -i 's/^#\(.*istore\)/\1/' feeds.conf.default

# Add feed sources
echo >> feeds.conf.default
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
./scripts/feeds update istore
./scripts/feeds install -d y -p istore luci-app-store

# Modify default theme（FROM luci-theme-bootstrap CHANGE TO luci-theme-argon-light-green）
sed -i 's/luci-theme-ifit/luci-theme-argon-light-green/g' ./feeds/luci/collections/luci/Makefile



