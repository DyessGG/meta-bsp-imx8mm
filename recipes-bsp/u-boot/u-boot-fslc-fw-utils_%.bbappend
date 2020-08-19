FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

UBOOT_SRC ?= "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2018.03_4.14.98_2.0.0_ga"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "87a19df5e462f1f63e8a6d2973c7fb9e95284d04"

include compulab/imx8mm.inc

SRC_URI =+ "file://fw_env.config \
"

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

do_install_prepend () {
	if [ -e ${WORKDIR}/fw_env.config ]; then
		sed -i -e \
		's:\(.*/dev/mmcblk[^[:blank:]]*\)[[:blank:]].*$:\1 ${UBOOT_ENV_OFFSET} ${UBOOT_ENV_SIZE}:' \
			${WORKDIR}/fw_env.config
	else
		bbfatal "fw_env.config not found in ${WORKDIR}"

	fi
}

RPROVIDES_${PN} += "u-boot-fw-utils"
