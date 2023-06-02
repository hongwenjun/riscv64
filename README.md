![riscv.webp](https://raw.githubusercontent.com/hongwenjun/riscv64/main/img/riscv.webp)

# [riscv64](https://hub.docker.com/r/hongwenjun/riscv64)

`Docker` 版 `RISC-V` 交叉编译器和执行 `riscv-pke` 的环境(Spike RISC-V ISA Simulator)

## 中国大陆使用阿里云镜像安装 `Docker` 服务
```
wget get.docker.com -O get.docker.sh
bash  get.docker.sh  --mirror Aliyun
```
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
- 挂载目录 `-v /app:/app` ,前一个是宿主机目录，后一个是容器中挂载的目录 

## 进入容器 `riscv64` 
```
docker exec -it  riscv64 bash
```
![](https://github.com/hongwenjun/riscv64/blob/main/img/RiscV.gif)

### 另一种构建 Docker Riscv64 方法
https://github.com/hongwenjun/riscv64/blob/main/Another_way_to_build_Docker_Riscv64.md

### 最便宜RiscV单片机开发板学RISCV汇编指令
https://github.com/hongwenjun/riscv_learn

## ~~ 设置环境变量和测试编译器 `riscv64-unknown-elf-gcc` ~~

```
export PATH="$PATH:/RISCV/riscv64-elf-gcc/bin" 
riscv64-unknown-elf-gcc -v
```
- ~~ 建议将以上 `export命令` ，加入到 `~/.bashrc` 文件末尾，每次进入容器能自动加载环境变量。 ~~

- ~~ 编辑bash环境 `nano ~/.bashrc` ，参考如下 ~~
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

---

### 项目文件 [Dockerfile](https://github.com/hongwenjun/riscv64/blob/main/Dockerfile)
RISC-V 交叉编译器+执行环境(Spike RISC-V ISA Simulator)的tgz包: [riscv64-elf-gcc-20210923.tgz](https://gitee.com/hustos/pke-doc/blob/master/resources/riscv64-elf-gcc-20210923.tgz)

RISC-V Proxy Kernel and Boot Loader: [spike-ci.tar](https://github.com/riscv-software-src/riscv-pk)


### 参考文章: [华中科技大学操作系统团队/pke-doc](https://gitee.com/hustos/pke-doc/blob/master/chapter2_installation.md)

---

![riscv-color.svg](https://raw.githubusercontent.com/hongwenjun/riscv64/main/img/riscv-color.svg)

## [Spike RISC-V ISA Simulator](https://github.com/riscv-software-src/riscv-isa-sim) 
RISC-V ISA 模拟器 `Spike` 实现了一个或多个 RISC-V harts 的功能模型。 它以用来庆祝美国横贯大陆铁路建成的金色道钉而得名。

## 交互式调试模式
要调用交互式调试模式，请使用 -d 启动 spike:

    $ spike -d pk hello

要查看整数寄存器的内容（0 代表核心 0）:

    : reg 0 a0

要查看浮点寄存器的内容:

    : fregs 0 ft0

或者:

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

## [RARS——RISC-V 汇编器和运行时模拟器](https://github.com/TheThirdOne/rars)
RARS，即 RISC-V 汇编程序、模拟器和运行时，将汇编和模拟 RISC-V 汇编语言程序的执行。 它的主要目标是为开始使用 RISC-V 的人们提供一个有效的开发环境。

### 文档
可以在 wiki 上找到有关支持的指令、系统调用、汇编器指令等的文档。 可以通过帮助菜单访问下载中包含的文档。

### instructions
https://github.com/TheThirdOne/rars/wiki/Supported-Instructions

### system calls
https://github.com/TheThirdOne/rars/wiki/Environment-Calls

### assembler directives
https://github.com/TheThirdOne/rars/wiki/Assembler-Directives


## [学习 Risc-V 汇编, 使用 gcc -S 命令转换C语言源码成 RISC-V 汇编代码](https://262235.xyz/index.php/archives/1276/)

当使用 `riscv32-unknown-elf-gcc -S` 命令时，会将 C 语言源代码转换成 RISC-V 汇编代码。
以下是一些常用的 RISC-V 汇编指令及其含义，以供参考：

- `add`: 将两个数相加。
- `addi`: 将一个数和一个立即数相加。
- `sub`: 从一个数中减去另一个数。
- `mul`: 将两个数相乘。
- `div`: 将一个数除以另一个数。
- `rem`: 取两个数的余数。
- `and`: 对两个数进行按位与操作。
- `or`: 对两个数进行按位或操作。
- `xor`: 对两个数进行按位异或操作。
- `sll`: 将一个数左移指定的位数。
- `srl`: 将一个数右移指定的位数。
- `sra`: 将一个有符号数右移指定的位数。
- `slt`: 如果第一个数小于第二个数，则将目标寄存器设置为 1，否则设置为 0。
- `slti`: 如果一个数小于一个立即数，则将目标寄存器设置为 1，否则设置为 0。
- `beq`: 如果两个寄存器相等，则跳转到指定的标签。
- `bne`: 如果两个寄存器不相等，则跳转到指定的标签。
- `blt`: 如果第一个寄存器小于第二个寄存器，则跳转到指定的标签。
- `bge`: 如果第一个寄存器大于等于第二个寄存器，则跳转到指定的标签。
- `j`: 无条件跳转到指定的标签。
- `jal`: 跳转到指定的标签，并将返回地址保存到目标寄存器中。
- `jr`: 跳转到目标寄存器所指向的地址。
- `jalr`: 跳转到目标寄存器所指向的地址，并将返回地址保存到指定的寄存器中。
- `lw`: 从内存中加载一个字（32 位）到目标寄存器中。
- `sw`: 将一个字（32 位）存储到内存中。
- `li`: 将一个立即数加载到目标寄存器中。
- `mv`: 将一个寄存器的值复制到另一个寄存器中。
- `la`: 将一个标签的地址加载到目标寄存器中。
- `auipc`: 将 PC 的高 20 位与一个立即数相加，并将结果存储到目标寄存器中。
- `lui`: 将一个立即数的高 20 位加载到目标寄存器中。

```
void mystrcpy(char *s, char *t)
{
	while (*s++ = *t++)
		;
}
```

这是一个简单的 C 语言函数，它的作用是将字符串 `t` 复制到字符串 `s` 中，包括字符串末尾的空字符。以下是该函数的汇编代码及其注释：

```assembly
mystrcpy:
    # 函数 prologue：保存寄存器并分配栈空间
    addi    sp, sp, -16      # 为 s 和 t 分配 8 字节的空间
    sw      ra, 12(sp)       # 保存返回地址
    sw      s0, 8(sp)        # 保存 s0
    sw      s1, 4(sp)        # 保存 s1

    # 函数体
    add     s0, x0, a0       # 将 s 的地址保存到 s0 中
    add     s1, x0, a1       # 将 t 的地址保存到 s1 中
loop:
    lbu     t0, 0(s1)        # 将 t 所指向的字节读入 t0 中
    addi    s1, s1, 1        # 将 t 指针加 1，指向下一个字节
    sb      t0, 0(s0)        # 将 t0写入 s 所指向的地址中，同时将 s 指针加 1，指向下一个字节
    bnez    t0, loop         # 如果 t0 不为 0（即还没有到字符串末尾），则跳转到 loop

    # 函数 epilogue：恢复寄存器并返回
    lw      ra, 12(sp)       # 恢复返回地址
    lw      s0, 8(sp)        # 恢复 s0
    lw      s1, 4(sp)        # 恢复 s1
    addi    sp, sp, 16       # 释放栈空间
    ret                     # 返回
```

下面是各条指令的注释：

- `addi sp, sp, -16`: 分配 16 字节的栈空间，用于存储返回地址、寄存器和参数。
- `sw ra, 12(sp)`: 保存返回地址。
- `sw s0, 8(sp)`: 保存寄存器 s0。
- `sw s1, 4(sp)`: 保存寄存器 s1。
- `add s0, x0, a0`: 将 s 的地址保存到寄存器 s0 中。
- `add s1, x0, a1`: 将 t 的地址保存到寄存器 s1 中。
- `loop`: 标签，用于循环。
- `lbu t0, 0(s1)`: 从 t 所指向的地址读取一个字节，保存到寄存器 t0 中。
- `addi s1, s1, 1`: 将寄存器 s1 中的地址加 1，指向下一个字节。
- `sb t0, 0(s0)`: 将寄存器 t0 中的字节写入 s 所指向的地址中，并将寄存器 s0 中的地址加 1，指向下一个字节。
- `bnez t0, loop`: 如果寄存器 t0 中的值不为 0，则跳转到 loop 标签，继续循环。
- `lw ra, 12(sp)`: 恢复返回地址。
- `lw s0, 8(sp)`: 恢复寄存器 s0。
- `lw s1, 4(sp)`: 恢复寄存器 s1。
- `addi sp, sp, 16`: 释放栈空间。
- `ret`: 返回。

## 实际 `rvcc -S strcpy.c` 翻译汇编代码
```
	.text
mystrcpy:
	add	sp,sp,-32   // sp栈，实际分配内存32字节
	sw	s0,28(sp)   // 还要保存sp指针和返回地址等值
	add	s0,sp,32

    // 实际 s 和 t 参数那个先分配由编译器决定
	sw	a0,-20(s0)  // char *s  函数参数的内存地址
	sw	a1,-24(s0)  // char *t  
	nop
.L2:
	lw	a4,-24(s0)  // lw 从内存加载 t 的地址
	add	a5,a4,1     // t++
	sw	a5,-24(s0)  // sw 保存 t 到内存中

	lw	a5,-20(s0)  // lw 从内存加载 s 的地址
	add	a3,a5,1     // s++
	sw	a3,-20(s0)  // sw 保存 s 到内存中

	lbu	a4,0(a4)    // 将 t 所指向的字节读入 t0 中
	sb	a4,0(a5)    // *t = *s  将值复制
	lbu	a5,0(a5)   
	bnez	a5,.L2   // 如果等于0，继续循环 .L2
	nop

	lw	s0,28(sp)   // sp栈，回收内存
	add	sp,sp,32
	jr	ra

```

## 常见的 `x86` 汇编指令及其含义
当使用 `gcc -S` 命令时，会将 C 语言源代码转换成汇编代码。
以下是一些常见的 `x86` 汇编指令及其含义，以供参考：

- `mov`: 将数据从一个位置移动到另一个位置。
- `add`: 将两个数相加。
- `sub`: 从一个数中减去另一个数。
- `mul`: 将两个数相乘。
- `div`: 将一个数除以另一个数。
- `push`: 将一个值压入栈中。
- `pop`: 将一个值从栈中弹出。
- `call`: 跳转到一个函数。
- `ret`: 返回函数调用的地方。
- `jmp`: 无条件跳转到另一个位置。
- `cmp`: 比较两个值的大小。
- `je`: 如果相等则跳转。
- `jne`: 如果不相等则跳转。
- `jg`: 如果大于则跳转。
- `jge`: 如果大于等于则跳转。
- `jl`: 如果小于则跳转。
- `jle`: 如果小于等于则跳转。
- `lea`: 计算一个地址，但不访问这个地址。
- `movzx`: 将一个字节或字的无符号整数零扩展为另一个寄存器。
- `movsx`: 将一个字节或字的有符号整数符号扩展为另一个寄存器。
- `and`: 对两个数进行按位与操作。
- `or`: 对两个数进行按位或操作。
- `xor`: 对两个数进行按位异或操作。
- `not`: 对一个数进行按位取反操作。
- `shl`: 将一个数左移指定的位数。
- `shr`: 将一个数右移指定的位数。
- `inc`: 将一个数加 1。
- `dec`: 将一个数减 1。
