# Building Linux Kernel for CompuLab's i.MX8M Mini products

Supported machines:

* `iot-gate-imx8`

Define a `MACHINE` environment variable for the target product:

<pre>
export MACHINE=iot-gate-imx8
</pre>

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP release name|export NXP_RELEASE=rel_imx_5.4.24_2.1.0|
|CompuLab branch name|export CPL_BRANCH=iot-gate-imx8_r2.5|

## Prerequisites
It is up to developer to setup arm64 build environment:
* Download the [Linaro tool chain](https://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/aarch64-linux-gnu/)
* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-
</pre>
* Create a folder to organize the files:
<pre>
mkdir imx8mm
cd imx8mm
</pre>
* Download CompuLab BSP
<pre>
git clone -b ${CPL_BRANCH} https://github.com/compulab-yokneam/meta-bsp-imx8mm.git
export PATCHES=$(pwd)/meta-bsp-imx8mm/recipes-kernel/linux/compulab/imx8mm
</pre>

## CompuLab Linux Kernel setup
<pre>
git clone https://source.codeaurora.org/external/imx/linux-imx.git
git -C linux-imx checkout -b linux-compulab ${NXP_RELEASE}
git -C linux-imx am ${PATCHES}/*.patch
</pre>

## Compile the Kernel
<pre>
make -C linux-imx ${MACHINE}_defconfig
make -C linux-imx
</pre>
