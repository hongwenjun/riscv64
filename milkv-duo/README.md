## Milkv-duo镜像包含 Python 3.9.5 和 pip3 nano htop vim tmux screen neofetch git gdb

## milkv-duo-20230910-0623.img.7z      37.8 MB (39,688,017 字节)
- github下载  https://github.com/hongwenjun/riscv64/tree/main/milkv-duo

- 中国下载地址:   https://wwcz.lanzout.com/i3Qkh17wwl4d

![milkv_duo_musl_riscv64_defconfig|688x500](upload://wCMfvKwRsY8NPPPIiZkfyoxN4Hi.gif)

##  参考上图，使用  make menuconfig 命令 添加软件包
```
cd /root/duo-buildroot-sdk/buildroot-2021.05
make milkv_duo_musl_riscv64_defconfig
make menuconfig
```

## 保存文件成 `configs/milkv_duo_musl_riscv64_defconfig`
可以复制粘贴到窗口中

##  编译的时候会自动外网下载 软件包源码，所以编译前使用类似命令添加 http 代理
```
http_proxy=http://192.168.1.135:58010
export http_proxy=$http_proxy
export https_proxy=$http_proxy
```

##  最后执行一键编译脚本 build_milkv.sh
./build_milkv.sh

## 为什么查看RAM只显示28M?
因为有一部分RAM被分配绐了ION，修改这个 ION_SIZE 的值为0然后编译生成固件
```
vim build/boards/cv180x/cv1800b_milkv_duo_sd/memmap.py
#  memmap.py 文件第43行  改成  ION_SIZE = 0 * SIZE_1M
ION_SIZE = 26.80078125 * SIZE_1M
```

![QQ截图20230910144515|690x451](upload://59YC7MSeIHv3PFSLcwb9nmbJrSU.png)

编译选了些软件 有 python pip3 nano vim less grep

因为选了mc 失败了2次，把 mc 取消通过编译了


### milkv-duo-20230907-1536.img.7z	29.2 MB (30,623,082 字节)

- 内存 64MB 可用,  包含  Python 3.9.5  和 pip3 
- sqlite3  git 7zr zip zstd htop 和 nano 文本编辑器

```
pip3 list
Package           Version  
----------------- ---------
certifi           2020.12.5
chardet           4.0.0    
click             7.1.2    
Flask             1.1.2    
idna              2.10     
itsdangerous      1.1.0    
Jinja2            2.11.3   
MarkupSafe        1.1.1    
oauthlib          3.1.0    
Pillow            8.2.0    
pip               20.0.2   
PyMySQL           0.9.3    
PyQRCode          1.2.1    
regex             2021.4.4 
request-id        1.0      
requests          2.25.1   
requests-oauthlib 1.3.0    
setuptools        44.0.0   
six               1.15.0   
urllib3           1.26.4   
WebOb             1.8.6    
Werkzeug          1.0.1  
```

### rufus-4.2.exe   另一款 Milkv-duo镜像 img 写TF卡工具
--------------------------------------------------

- 基础编译的，只修改内存 64MB 可用
### milkv-duo-20230905-1513.img.7z    14.1 MB (14,848,935 字节)

- 内存 64MB 可用,  包含  Python 3.9.5
### milkv-duo-20230906-1422.img.7z    19.7 MB (20,717,219 字节)

### USBWriter.exe   使用本工具 把解压出的 img 文件写到 TF 卡

### milkv-duo-tinycc.zip   8.70 MB (9,131,348 字节)
- milkv-duo 开发板上可以运行的 C语言编译器
```
以上资源 蓝奏云 分享链接
https://wwcz.lanzout.com/b01xbg29i
密码:bx54
```

=========================================
## milkv-duo 证书登录 TF卡扩容 Linux 虚拟网卡IP添加
```
﻿# 证书登录
chown -R root:root /root
mkdir -p ~/.ssh  && cd ~/.ssh

cat <<EOF >>  authorized_keys
ssh-rsa AAAAB...此处填证书公钥...Mk63 root
EOF

#  TF卡扩容
fdisk -l
fdisk /dev/mmcblk0

# p 命令查看分区
# d 删除 第二分区
# n 重新建立分区，选主分区，然后按回车选默认
# w 保存设置 q 退出

reboot

# 重启后分区大小正确，需要 resize2fs 修复空间
df -h
resize2fs /dev/mmcblk0p2


# 使用 Linux 系统接开发板 虚拟网卡IP添加
ip a

ni=usb0

ip link set $ni up
ip addr add 192.168.42.2/24 dev $ni

ping 192.168.42.1
```