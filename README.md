# UniversalOS 融合化系统——天下大同
✨ **UniversalOS/IntegratedOS/FusionOS/All-in-one-OS ➤ BetterLife！**

👉 **自动获取、编译或生成各类最新系统，探索各类系统实现同时统一融合运行，最优化激发设备潜能。**

🎯 **与时俱进，关注前沿最新技术，追求更加美好生活！不依赖于固定方案，如有更好选择，可整体迁移。**

⏰ **当前关注方案：**
   以LinuxOS为基础依托(Arch Linux, Ubuntu, Fedora, Armbian……)，以[Proxmox Virtual Environment(PVE)](https://proxmox.com/en/)开源虚拟化管理平台为主，同时使用KVM虚拟机([Kernel-based Virtual Machine](https://linux-kvm.org/page/Main_Page)、[QEMU](https://blog.csdn.net/qq_55914897/article/details/132218294))和LXC容器[(Linux Containers)](https://linuxcontainers.org/)[两种技术](https://blog.csdn.net/z609932088/article/details/143642199)，辅以[Docker](https://hub.docker.com/)/[Podman](https://podman.io/) [Containers](https://www.imooc.com/article/375232)、[Kata Containers](https://www.cnblogs.com/renshengdezheli/p/18259251)/[gVisor](https://www.cnblogs.com/renshengdezheli/p/18258180)等容器技术，佐以[Wine(Wine Is Not an Emulator)](https://www.winehq.org/)、[CrossOver、Snap、Flatpak](https://tieba.baidu.com/p/8540464149)、虚拟机(VMVare、VirtualBox、QEMU)、模拟器(Android、街机等)等软件服务，实现Linux、OpenWrt、NAS、Android、Windows、MacOS等各类系统同时运行、轻量灵活、统一管理、互相配合、联通共享，动态调配资源利用强度，丰富部署个性化网络(OpenWrt)、去广告服务(AdguardHome)、NAS管理(群晖DSM、飞牛OS等)、各大网盘合一(Alist等)、影视音乐(Kodi等)、远程游戏、感官娱乐、相册、家庭智能控制(HomeAssistant等)、云办公(GodoOS等)、开源个人笔记(wiznote为知笔记等)、个人网站(WordPress等)、远程主机、自动化任务(青龙面板等)、机器人控制([RobotOS](https://baijiahao.baidu.com/s?id=1821442456542439713)等)等全方位服务，真正做到融合与共、潜能激活、多效迸发、天下大同！


<br />


  </a>
  <h3 align="center">UniversalOS 融合式系统——天下大同</h3>
  <p align="center">
    👉 定期自动拉取最新源码编译打包，自动发布到 [<a herf="https://github.com/FoxDring/UniversalOS/releases"> Releases </a>]👈
    <br />
    <a href="https://github.com/FoxDring/UniversalOS/tree/main/%40Documents"><strong>探索本项目的教程 »</strong></a>
    <br />
    <a href="https://github.com/FoxDring/UniversalOS/tree/main/%40Readme">查看本项目的说明 »</a>
	<br />
    <br />
    <a href="https://github.com/FoxDring/UniversalOS/releases">下载地址</a>
    ·
    <a href="https://github.com/FoxDring/UniversalOS/actions">Actions</a>
    ·
    <a href="https://github.com/FoxDring/UniversalOS/issues">提出新特性</a>
  </p>

</p>

## 目录

- [UniversalOS 融合式系统——天下大同](#UniversalOS 融合式系统——天下大同)
  - [目录](#目录)
  - [项目源头](#项目源头)
  - [默认设置](#默认设置)
  - [固件特性](#固件特性)
  - [自带插件](#自带插件)
  - [定制固件](#定制固件)   
  - [注意事项](#注意事项)


<br>


## 项目源头

|         类别         |           🎯项目源头        |         作者         |        仓库地址         |              下载页          |
| :------------------------: | :---------------------: | :-------------------: | :-------------------: | :--------------------------: |
|  [Kernel] |             Kernel-ophub                    |  ophub |[🍕](https://github.com/ophub/kernel) |  [✔](https://github.com/ophub/kernel/tags) |
|  [Kernel] |             Kernel-breakingbadboy(flippy)                    |  breakingbadboy |[🍕](https://github.com/breakingbadboy/OpenWrt) |  [✔](https://github.com/breakingbadboy/OpenWrt/tags) |
|  [Kernel] |             Kernel-dring                    |  dring |[🍕](https://github.com/FoxDring/UniversalOS) |  [✔](https://github.com/FoxDring/UniversalOS/tags) |
|  [Armbian] |             Armbian-ophub                    |  ophub |[🍕](https://github.com/ophub/amlogic-s9xxx-armbian) |  [✔](https://github.com/ophub/amlogic-s9xxx-armbian/tags) |
|  [Armbian] |             Armbian-dring                    |  dring |[🍕](https://github.com/FoxDring/UniversalOS) |  [✔](https://github.com/FoxDring/UniversalOS/tags) |
|  [OpenWrt] |             OpenWrt-Official                    |  OpenWrt |[🍕](https://github.com/openwrt/openwrt) |  [✔](https://firmware-selector.openwrt.org/) |
|  [OpenWrt] |             OpenWrt-LEDE                    |  Lean |[🍕](https://github.com/coolsnowwolf/lede) |  [✔](https://github.com/coolsnowwolf/lede/releases) |
|  [OpenWrt] |             OpenWrt-ImmortalWrt                    |  ImmortalWrt |[🍕](https://github.com/immortalwrt/immortalwrt) |  [✔](https://github.com/immortalwrt/immortalwrt/tags) |
|  [OpenWrt] |             OpenWrt-flippy打包脚本                    |  flippy |[🍕](https://github.com/unifreq/openwrt_packit) |  [✔](https://github.com/unifreq/openwrt_packit) |
|  [OpenWrt] |             OpenWrt-breakingbadboy                    |  breakingbadboy |[🍕](https://github.com/breakingbadboy/OpenWrt) |  [✔](https://github.com/breakingbadboy/OpenWrt/tags) |
|  [OpenWrt] |             OpenWrt-ophub                    |  ophub |[🍕](https://github.com/ophub/amlogic-s9xxx-openwrt) |  [✔](https://github.com/ophub/amlogic-s9xxx-openwrt/tags) |
|  [OpenWrt] |             OpenWrt-ophub打包的flippy固件                    |  ophub |[🍕](https://github.com/ophub/flippy-openwrt-actions) |  [✔](https://github.com/ophub/flippy-openwrt-actions/tags) |
|  [OpenWrt] |             OpenWrt-laiyujun                    |  laiyujun |[🍕](https://github.com/laiyujun/Actions_OpenWrt-Amlogic) |  [✔](https://github.com/laiyujun/Actions_OpenWrt-Amlogic/tags) |
|  [OpenWrt] |             OpenWrt-dring                    |  dring |[🍕](https://github.com/FoxDring/UniversalOS) |  [✔](https://github.com/FoxDring/UniversalOS/tags) |
|  [OpenWrt] |             OpenWrt-docker-dring                    |  dring |[🍕](https://hub.docker.com/repository/docker/foxdring/openwrt-aarch64/general) |  [✔](https://hub.docker.com/repository/docker/foxdring/openwrt-aarch64/tags) |



<br>

### 默认设置
🎯Armbian 默认设置
- Armbian地址: `从路由器获取IP`
- 默认用户名: `root`
- 默认密码  : `1234`
- 安装命令  : `armbian-install`
- 升级命令  : `armbian-update`

<br>
🎯OpenWrt 默认设置
- OpenWrt地址: `192.168.1.1`
- 默认用户名: `root`
- 默认密码  : `password`
- 无线名称  : `OpenWrt`
- 无线密码  : `无/none`
- 安装方式  : `晶晨宝盒`
<br>



## 固件特性
⏰ 固件编译频率设置为`源码更新自动编译`(稳定为主，减少资源浪费)

✨ iStore应用商店 [AppStore]

✨ 自带常用的插件

✨ Arm集成所有openwrt的USB驱动

✨ ~~集成Python3.x(带pip)环境~~

✨ 集成Docker-CE

✨ ~~集成Node.js(14.xLTS 带npm、yarn)~~

✨ 全新的 [Theme](https://github.com/jerrykuku/luci-theme-argon)

✨ x86_64 vmdk固件集成vm-tools

✨ x86_64 iso格式镜像

✨ x86_64 Lite版本(必要插件&应用商店)

<br>

## 自带插件
🍕 默认插件


<br>

## 定制固件
1. Fork 此项目
2. 按需修改 ```configure.sh``` 和 ```package.sh``` 文件
3. 上传你自己的 ```xx.config``` 配置文件到configs目录
4. 添加或修改自己的``````xx.yml``````文件
5. 最后根据个人喜好修改 ```update-checker.yml``` 需自行添加 ```Actions secrets``` (触发自动编译)

### 注意事项：
📌 修改默认系统参数 👉 ```configure.sh```   
📌 添加其它Luci插件 👉 ```package.sh```   
📌 插件 / 应用配置文件 👉 ```configs/Standard.config```   
<br>



# [NestingDNS](https://github.com/217heidai/NestingDNS)
DNS三大神器 [AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)、[MosDNS](https://github.com/IrineSistiana/mosdns)、[SmartDNS](https://github.com/pymumu/smartdns)全都要，套娃使用三大神器，试图找到一套最佳实践。
