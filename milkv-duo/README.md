## Milkv-duo镜像包含 Python 3.9.5 和 pip3  nano

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