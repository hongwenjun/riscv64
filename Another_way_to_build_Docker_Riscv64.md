## 另一种构建 Docker Riscv64 方法

```
docker run -it ubuntu bash

docker run -itd  --restart=always   \
    -v /app:/app  --name riscv64 \
    ubuntu  sh

docker exec -it  riscv64 bash


apt update

apt install autoconf automake autotools-dev curl libmpc-dev \
	libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk build-essential \
	bison flex texinfo gperf libtool patchutils bc zlib1g-dev \
	device-tree-compiler pkg-config libexpat-dev
	
apt install qemu qemu-user nano


wget https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2023.02.25/riscv64-elf-ubuntu-22.04-nightly-2023.02.25-nightly.tar.gz

tar xf  riscv64-elf-ubuntu-22.04-nightly-2023.02.25-nightly.tar.gz


# 编译 spike
https://github.com/riscv-software-src/riscv-isa-sim

apt-get install device-tree-compiler
mkdir build
cd build
../configure --prefix=/riscv/
make
make install


spike pk hello  错误解决
terminate called after throwing an instance of 'std::runtime_error'
  what():  could not open pk; searched paths:
	. (current directory)
	/riscv64-unknown-elf/bin/ (based on configured --prefix and --with-target)


wget  spike-ci.tar
tar xf  spike-ci.tar

spike /root/pk hello


# 首先 加载环境变量
export PATH="$PATH:/riscv/bin"

riscv64-unknown-elf-gcc -v
```