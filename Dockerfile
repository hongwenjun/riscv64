FROM debian:stable-slim
RUN  apt update -y && \
     apt install -y --no-install-recommends --no-install-suggests nano  device-tree-compiler  && \
     rm -rf /var/lib/apt/lists/*   /var/cache/apt && \
     mkdir /RISCV

WORKDIR  /RISCV
ADD ./spike-ci.tar  .
ADD ./riscv64-elf-gcc-20210923.tgz  .

#################################################

RUN  echo ZXhwb3J0IExTX09QVElPTlM9Jy0tY29sb3I9YXV0bycKYWxpYXMgbHM9J2xzICRMU19PUFRJT05T\
JwphbGlhcyBsbD0nbHMgJExTX09QVElPTlMgLWwnCgpleHBvcnQgUEFUSD0iJFBBVEg6L1JJU0NW\
L3Jpc2N2NjQtZWxmLWdjYy9iaW4iCnJpc2N2NjQtdW5rbm93bi1lbGYtZ2NjIC12CgphbGlhcyBy\
dmNjPXJpc2N2NjQtdW5rbm93bi1lbGYtZ2NjCg==\
	| base64 -d >> ~/.bashrc

# 使用 base64 添加和加载环境变量
# export PATH="$PATH:/RISCV/riscv64-elf-gcc/bin"
# riscv64-unknown-elf-gcc -v

# spike pk hello
# spike /RISCV/pk  hello
