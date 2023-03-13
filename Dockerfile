FROM debian:stable-slim
RUN  apt update -y && \
     apt install -y --no-install-recommends --no-install-suggests nano  device-tree-compiler  && \
     rm -rf /var/lib/apt/lists/*   /var/cache/apt && \
     mkdir /RISCV

WORKDIR  /RISCV
ADD ./spike-ci.tar  .
ADD ./riscv64-elf-gcc-20210923.tgz  .

#################################################

# 首先 加载环境变量
# export PATH="$PATH:/RISCV/riscv64-elf-gcc/bin"

# riscv64-unknown-elf-gcc -v

# spike pk hello
# spike /RISCV/pk  hello

