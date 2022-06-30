set -e
set -x

# build and install
cd /root
mkdir xrt-git
git clone https://github.com/Xilinx/XRT xrt-git
cd xrt-git
git checkout -b temp tags/202210.2.13.466

cd build
chmod 755 build.sh
XRT_NATIVE_BUILD=no ./build.sh -dbg
cd Debug
make install

# Build and install xclbinutil
cd ../../
mkdir xclbinutil_build
sed -i 's/xdp_hw_emu_device_offload_plugin xdp_core xrt_coreutil xrt_hwemu/xdp_core xrt_coreutil/g' ./src/runtime_src/xdp/CMakeLists.txt
cd xclbinutil_build/
cmake ../src/
make install -C runtime_src/tools/xclbinutil
mv /opt/xilinx/xrt/bin/unwrapped/xclbinutil /usr/local/bin/xclbinutil
rm -rf /opt/xilinx/xrt

# put platform name for xrt app
echo ${PYNQ_BOARD} > /etc/xocl.txt

# cleanup
cd /root
rm -rf xrt-git
