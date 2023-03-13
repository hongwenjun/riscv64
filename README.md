# [riscv64](https://hub.docker.com/r/hongwenjun/riscv64)

`Docker` 版 `RISC-V` 交叉编译器和执行 `riscv-pke` 的环境(Spike RISC-V ISA Simulator)

## [Docker Pull 命令]((https://hub.docker.com/r/hongwenjun/riscv64))
```
docker pull hongwenjun/riscv64
```

## 建立 RISCV 容器 `riscv64`
```
docker run -itd  --restart=always   \
    -v /app:/app  --name riscv64 \
    hongwenjun/riscv64  sh
```

## 进入容器 `riscv64` 
```
docker exec -it  riscv64 bash
```

## 设置环境变量和测试编译器 `riscv64-unknown-elf-gcc`

```
export PATH="$PATH:/RISCV/riscv64-elf-gcc/bin"
riscv64-unknown-elf-gcc -v
```
- 建议将以上 `export命令` ，加入到 `~/.bashrc` 文件末尾，每次进入容器能自动加载环境变量。

- 编辑bash环境 `nano ~/.bashrc` ，参考如下
```
export LS_OPTIONS='--color=auto'
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'

export PATH="$PATH:/RISCV/riscv64-elf-gcc/bin"
riscv64-unknown-elf-gcc -v
```

## 编译和运行一个简单的 C 程序

- 编写一个简短的 C 程序并将其命名为 `hello.c`  然后，将其编译成名为 hello 的 RISC-V ELF 二进制文件：
```
riscv64-unknown-elf-gcc -o hello hello.c
```

- 现在您可以在代理内核上模拟程序：

```
spike pk hello
```

### 如果当前目录没有 `pk` 文件，可以使用 `/RISCV/pk` ，或者先复制到当前目录 
```
spike /RISCV/pk  hello
cp /RISCV/pk . && spike pk hello
```


### 项目文件 [Dockerfile](https://github.com/hongwenjun/riscv64/blob/main/Dockerfile)
RISC-V 交叉编译器+执行环境(Spike RISC-V ISA Simulator)的tgz包: [riscv64-elf-gcc-20210923.tgz](https://gitee.com/hustos/pke-doc/blob/master/resources/riscv64-elf-gcc-20210923.tgz)

RISC-V Proxy Kernel and Boot Loader: [spike-ci.tar](https://github.com/riscv-software-src/riscv-pk)



### 参考文章: [华中科技大学操作系统团队/pke-doc](https://gitee.com/hustos/pke-doc/blob/master/chapter2_installation.md)

---

## [Spike RISC-V ISA Simulator](https://github.com/riscv-software-src/riscv-isa-sim) 
RISC-V ISA 模拟器 `Spike` 实现了一个或多个 RISC-V harts 的功能模型。 它以用来庆祝美国横贯大陆铁路建成的金色道钉而得名。

Interactive Debug Mode
To invoke interactive debug mode, launch spike with -d:

    $ spike -d pk hello

To see the contents of an integer register (0 is for core 0):

    : reg 0 a0

To see the contents of a floating point register:

    : fregs 0 ft0

or:

    : fregd 0 ft0

depending upon whether you wish to print the register as single- or double-precision.

To see the contents of a memory location (physical address in hex):

    : mem 2020

To see the contents of memory with a virtual address (0 for core 0):

    : mem 0 2020

You can advance by one instruction by pressing the enter key. You can also execute until a desired equality is reached:

    : until pc 0 2020                   (stop when pc=2020)
    : until reg 0 mie a                 (stop when register mie=0xa)
    : until mem 2020 50a9907311096993   (stop when mem[2020]=50a9907311096993)

Alternatively, you can execute as long as an equality is true:

    : while mem 2020 50a9907311096993

You can continue execution indefinitely by:

    : r

At any point during execution (even without -d), you can enter the interactive debug mode with <control>-<c>.

To end the simulation from the debug prompt, press <control>-<c> or:

    : q