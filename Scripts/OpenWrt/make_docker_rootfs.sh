#!/bin/bash

#================================================================================================
# This file is licensed under the terms of the GNU General Public
# License version 2. This program is licensed "as is" without any
# warranty of any kind, whether express or implied.
#
# Description: Creating a Docker Image
#
# Command: ./Scripts/make_docker_image.sh
#
#==========================================================================
# Description: Build OpenWrt using GitHub Actions
# Copyright (C) https://github.com/unifreq/openwrt_packit
# Copyright (C) https://github.com/ophub/kernel
# Copyright (C) https://github.com/ophub/flippy-openwrt-actions
# Copyright (C) https://github.com/ophub/amlogic-s9xxx-openwrt
# Copyright (C) https://github.com/breakingbadboy/OpenWrt
# Copyright (C) https://github.com/laiyujun/Actions_OpenWrt-Amlogic
# Copyright (C) https://github.com/P3TERX/Actions-OpenWrt
#--------------------------------------------------------------------------
# Description: Build Docker image of OpenWrt
# Instructions: https://github.com/docker/build-push-action
# Build and Push to: https://hub.docker.com/
# Copyright (C) https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/.github/workflows/build-the-docker-image-of-openwrt.yml
# Copyright (C) https://github.com/breakingbadboy/OpenWrt/blob/main/.github/workflows/ARMv8_Docker_BuildX.yml
# Copyright (C) https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/config/docker/make_docker_image.sh
# Copyright (C) https://github.com/unifreq/openwrt_packit/blob/master/mk_openwrt_dockerimg.sh
# Copyright (C) https://github.com/breakingbadboy/OpenWrt/blob/main/opt/docker/buildImageX.sh
# Copyright (C) https://github.com/breakingbadboy/OpenWrt/blob/main/opt/docker/buildOfficial.sh
# Copyright (C) 
#==========================================================================



#======================================== Functions list ========================================
#
# error_msg         : Output error message
# check_depends     : Check dependencies
# find_openwrt_rootfs      : Find OpenWrt rootfs file (openwrt/*rootfs.tar.gz)
# adjust_settings   : Adjust related file settings
# make_docker_rootfs    : Make docker rootfs file
#
#================================ Set make environment variables ================================
#
# Set default parameters
current_path="${PWD}"
tmp_path="${current_path}/tmp"
out_path="${current_path}/out"
openwrt_rootfs_path="${current_path}"
openwrt_rootfs_file="*rootfs.tar.gz"
common_files="Config/OpenWrt/openwrt-files/common-files"
Dockerfile_path="Config/OpenWrt/openwrt-docker"
docker-files_path="Config/OpenWrt/openwrt-docker/docker-patches"
docker_rootfs="openwrt-armvirt-64-docker-rootfs.tar.gz"



# Set default parameters
STEPS="[\033[95m STEPS \033[0m]"
INFO="[\033[94m INFO \033[0m]"
SUCCESS="[\033[92m SUCCESS \033[0m]"
WARNING="[\033[93m WARNING \033[0m]"
ERROR="[\033[91m ERROR \033[0m]"
#
#================================================================================================


error_msg() {
    echo -e "${ERROR} ${1}"
    exit 1
}

check_depends() {
    # Check the necessary dependencies
    is_dpkg="0"
    dpkg_packages=("tar" "gzip")
    i="1"
    for package in ${dpkg_packages[*]}; do
        [[ -n "$(dpkg -l | awk '{print $2}' | grep -w "^${package}$" 2>/dev/null)" ]] || is_dpkg="1"
        let i++
    done

    # Install missing packages
    if [[ "${is_dpkg}" -eq "1" ]]; then
        echo -e "${STEPS} Start installing the necessary dependencies..."
        sudo apt-get update
        sudo apt-get install -y ${dpkg_packages[*]}
        [[ "${?}" -ne "0" ]] && error_msg "Dependency installation failed."
    fi
}

find_openwrt_rootfs() {
    cd ${current_path}
    echo -e "${STEPS} Start searching for OpenWrt rootfs file..."

    # Find whether the OpenWrt rootfs file exists
    openwrt_file_name="$(ls ${openwrt_rootfs_path}/${openwrt_rootfs_file} 2>/dev/null | head -n 1 | awk -F "/" '{print $NF}')"
    if [[ -n "${openwrt_file_name}" ]]; then
        echo -e "${INFO} OpenWrt rootfs file: [ ${openwrt_file_name} ]"
    else
        error_msg "There is no [ ${openwrt_rootfs_file} ] file in the [ ${openwrt_rootfs_path} ] directory."
    fi

    # Check whether the Dockerfile exists
    [[ -f "${Dockerfile_path}/Dockerfile" ]] || error_msg "Missing Dockerfile."
}

adjust_settings() {
    cd ${current_path}
    echo -e "${STEPS} Start adjusting OpenWrt file settings..."

    echo -e "${INFO} Unpack Openwrt."
    rm -rf ${tmp_path} && mkdir -p ${tmp_path}
    tar -xzf ${openwrt_rootfs_path}/${openwrt_file_name} -C ${tmp_path}

    # Remove useless files
    echo -e "${INFO} Remove useless files."
    rm -rf ${tmp_path}/lib/firmware/*
    rm -rf ${tmp_path}/lib/modules/*
    rm -f ${tmp_path}/root/.todo_rootfs_resize
    #find ${tmp_path} -name '*.rej' -exec rm {} \;
    #find ${tmp_path} -name '*.orig' -exec rm {} \;
    
	# Remove Amlogic Service
    rm -f ${tmp_path}/usr/lib/lua/luci/controller/amlogic.lua
    rm -rf ${tmp_path}/usr/lib/lua/luci/model/cbi/amlogic
    rm -rf ${tmp_path}/usr/share/amlogic
    rm -f ${tmp_path}/usr/sbin/openwrt-*-*
    rm -f ${tmp_path}/etc/init.d/amlogic
    
	# Remove docker Service
    rm -f ${tmp_path}/usr/lib/lua/luci/controller/docker*
    rm -rf ${tmp_path}/usr/lib/lua/luci/model/cbi/docker*
    rm -f ${tmp_path}/usr/lib/lua/luci/model/docker*
    rm -f ${tmp_path}/usr/bin/docker*
    rm -f ${tmp_path}/etc/init.d/docker*


    # Modify OpenWrt system files
	echo -e "${INFO} Modify OpenWrt system files."
	sed -e "s/\/bin\/ash/\/bin\/bash/" -i ${tmp_path}/etc/passwd && \
	sed -e "s/\/bin\/ash/\/bin\/bash/" -i ${tmp_path}/usr/libexec/login.sh
	
	chmod 755 ${docker-files_path}/30-sysinfo.sh && sudo cp -f ${docker-files_path}/30-sysinfo.sh ${tmp_path}/etc/profile.d/ && \
	sudo cp -f ${docker-files_path}/99-custom.conf "${tmp_path}/etc/sysctl.d/" && \
    sudo cp -f ${docker-files_path}/banner ${tmp_path}/etc/banner && \
	
	chmod 755 ${docker-files_path}/coremark.sh && sudo cp -f ${docker-files_path}/coremark.sh "${tmp_path}/etc/" && \
	rm -f "${tmp_path}/etc/bench.log" && echo "0 5 * * * /etc/coremark.sh" >> "${tmp_path}/etc/crontabs/root"
	
	chmod 755 ${docker-files_path}/cpustat && sudo cp -f ${docker-files_path}/cpustat "${tmp_path}/usr/bin/" && \	
	chmod 755 ${docker-files_path}/getcpu && sudo cp -f ${docker-files_path}/getcpu "${tmp_path}/bin/" && \	

	chmod 755 ${docker-files_path}/kmod
	# sudo cp -f ${docker-files_path}/kmod "${tmp_path}/sbin/" && \
		# (
	         # cd ${tmp_path}/sbin && \
	         # rm insmod lsmod modinfo modprobe rmmod && \
			 # ln -s kmod insmod && \
			 # ln -s kmod lsmod && \
			 # ln -s kmod modinfo && \
			 # ln -s kmod modprobe && \
			 # ln -s kmod rmmod 
		# )	

	sudo cp -f ${docker-files_path}/rc.local "${tmp_path}/etc/" && \
	sudo cp -f ${docker-files_path}/sysupgrade.conf ${tmp_path}/etc/ && \	

	cat ${docker-files_path}/luci-admin-status-index-html.patch | (cd "${tmp_path}/" && patch -p1) && \
	    cat ${docker-files_path}/luci-admin-status-index-html-02.patch | (cd "${tmp_path}/" && patch -p1)

	cat ${docker-files_path}/init.d_turboacc.patch | (cd "${tmp_path}/" && patch -p1 )
	if ! cat ${docker-files_path}/cbi_turboacc_new.patch | (cd "${tmp_path}/" && patch -p1 );then
	    cat ${docker-files_path}/cbi_turboacc.patch | (cd "${tmp_path}/" && patch -p1 )
	    ( find "${tmp_path}" -name '*.rej' -exec rm {} \; 
	      find "${tmp_path}" -name '*.orig' -exec rm {} \;
	    )
	fi	

	[ -f ${tmp_path}/etc/config/qbittorrent ] && sed -e 's/\/opt/\/etc/' -i "${tmp_path}/etc/config/qbittorrent"

	[ -f ${tmp_path}/etc/ssh/sshd_config ] && sed -e "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" -i "${tmp_path}/etc/ssh/sshd_config"

	#[ -f ${tmp_path}/etc/samba/smb.conf.template ] && cat patches/smb4.11_enable_smb1.patch | (cd "${tmp_path}" && [ -f etc/samba/smb.conf.template ] && patch -p1)

	sss=$(date +%s) && \
	ddd=$((sss/86400)) && \
	sed -e "s/:0:0:99999:7:::/:${ddd}:0:99999:7:::/" -i "${tmp_path}/etc/shadow" && \
	sed -e "s/root::/root:\$1\$0yUsq67p\$RC5cEtaQpM6KHQfhUSIAl\.:/" -i "${tmp_path}/etc/shadow"


    # Relink the kmod program
    [[ -f "${common_files}/sbin/kmod" ]] && (
        echo -e "${INFO} Relink the kmod program."
        sudo cp -f ${common_files}/sbin/kmod ${tmp_path}/sbin/kmod
        chmod 755 ${tmp_path}/sbin/kmod
        kmod_list="depmod insmod lsmod modinfo modprobe rmmod"
        for ki in ${kmod_list}; do
            rm -f ${tmp_path}/sbin/${ki}
            ln -sf kmod ${tmp_path}/sbin/${ki}
        done
    )

    # Turn off hw_flow by default
    [[ -f "${tmp_path}/etc/config/turboacc" ]] && {
        echo -e "${INFO} Adjust turboacc settings."
        sed -i "s|option hw_flow.*|option hw_flow '0'|g" ${tmp_path}/etc/config/turboacc
        #sed -i "s|option sw_flow.*|option sw_flow '0'|g" ${tmp_path}/etc/config/turboacc
		sed -i "s|option sfe_flow.*|option sfe_flow '0'|g" ${tmp_path}/etc/config/turboacc
    }

    # Modify the cpu mode to schedutil
    [[ -f "${tmp_path}/etc/config/cpufreq" ]] && {
        echo -e "${INFO} Adjust cpufreq settings"
        sed -i "s/ondemand/schedutil/g" ${tmp_path}/etc/config/cpufreq
    }

    # Modify the release version
    [[ -f "${tmp_path}/etc/openwrt_release" ]] && {
        echo -e "${INFO} Modify the release version"
        sed -i '/DISTRIB_REVISION/d' "${tmp_path}/etc/openwrt_release"
        sed -i '/DISTRIB_DESCRIPTION/d' "${tmp_path}/etc/openwrt_release"
        echo "DISTRIB_REVISION='R$(date +%Y.%m.%d)'" >> "${tmp_path}/etc/openwrt_release"
        echo "DISTRIB_DESCRIPTION='OpenWrt'" >> "${tmp_path}/etc/openwrt_release"
	}

    # Add version information to the banner
    [[ -f "${docker-files_path}/banner" ]] && {
        echo -e "${INFO} Add banner infomation."
        echo " Board: docker | Production Date: $(date +%Y.%m.%d)" >>${tmp_path}/etc/banner
        echo "───────────────────────────────────────────────────────────────────────" >>${tmp_path}/etc/banner
    }
}

make_docker_rootfs() {
    cd ${tmp_path}
    echo -e "${STEPS} Start making docker rootfs file..."

    # Make docker rootfs file
	# #创建.xz格式压缩文件
	# tar -cJf ${docker_rootfs} *    
	#创建.gz格式压缩文件
	tar -czf ${docker_rootfs} *

    [[ "${?}" -eq "0" ]] || error_msg "Docker rootfs file creation failed."

    # Move the docker rootfs file to the output directory
    rm -rf ${out_path} && mkdir -p ${out_path}
    sudo mv -f ${docker_rootfs} ${out_path}
    [[ "${?}" -eq "0" ]] || error_msg "Docker rootfs file move failed."
    echo -e "${INFO} Docker rootfs file packaging succeeded."

    cd ${current_path}

    # Add Dockerfile
    sudo cp -f ${Dockerfile_path}/Dockerfile ${out_path}
    [[ "${?}" -eq "0" ]] || error_msg "Dockerfile addition failed."
    echo -e "${INFO} Dockerfile added successfully."

    # Export to upload directory
    sudo cp -f ${out_path}/*  /workdir/upload/
    
	# Remove temporary directory
    rm -rf ${tmp_path}
    
	sync && sleep 3
    echo -e "${INFO} Docker rootfs file list: \n$(ls -l ${out_path})"
    echo -e "${SUCCESS} Docker rootfs file successfully created."
}

# Show welcome message
echo -e "${STEPS} Welcome to the Docker Image Maker Tool."
echo -e "${INFO} Make path: [ ${PWD} ]"
#
check_depends
find_openwrt_rootfs
adjust_settings
make_docker_rootfs
#
# All process completed
wait
