#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Function: 加载自定义feeds


# 【参考各种修改写法】：
# https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/config/lede-master/diy-part1.sh




# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

## 常用OpenWrt软件包源码合集，同步上游更新！
## 通用版luci适合18.06与19.07
# echo 'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default

# other
# rm -rf package/lean/{samba4,luci-app-samba4,luci-app-ttyd}

## 解除系统限制
ulimit -u 10000
ulimit -n 4096
ulimit -d unlimited
ulimit -m unlimited
ulimit -s unlimited
ulimit -t unlimited
ulimit -v unlimited

