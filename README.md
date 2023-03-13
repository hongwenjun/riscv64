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

## 交互式调试模式
交互式调试模式 要调用交互式调试模式，请使用 -d 启动 spike:

    $ spike -d pk hello

要查看整数寄存器的内容（0 代表核心 0）:

    : reg 0 a0

要查看浮点寄存器的内容:

    : fregs 0 ft0

or:

    : fregd 0 ft0

取决于您希望将寄存器打印为单精度还是双精度.

要查看内存位置的内容（十六进制物理地址）:

    : mem 2020

要查看具有虚拟地址（核心 0 为 0）的内存内容:

    : mem 0 2020

您可以按回车键前进一条指令。 您还可以执行直到达到所需的相等性:

    : until pc 0 2020                   (stop when pc=2020)
    : until reg 0 mie a                 (stop when register mie=0xa)
    : until mem 2020 50a9907311096993   (stop when mem[2020]=50a9907311096993)

或者，只要相等性为真，您就可以执行:

    : while mem 2020 50a9907311096993

您可以通过以下方式无限期地继续执行:

    : r

在执行期间的任何时候，您都可以使用 `Ctrl+c` 进入交互式调试模式。

要从调试提示符结束模拟，请按 `Ctrl+c` 或:

    : q
