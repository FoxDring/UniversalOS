# 源自flippy (https://github.com/unifreq/openwrt_packit/blob/master/Dockerfile)
# 源自ophub (https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/config/docker/Dockerfile)
# 源自breakingbadboy (https://github.com/breakingbadboy/OpenWrt/blob/main/opt/docker/Dockerfile)

FROM scratch
ADD openwrt-armvirt-64-docker-rootfs.tar.gz /
EXPOSE 22 53 80 443 7681
# using exec format so that /sbin/init is proc 1 (see procd docs)
ENTRYPOINT ["/sbin/init"]
MAINTAINER Dring
