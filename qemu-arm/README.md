
### 配置Qemu Arm32运行环境
参考博客：  
[1] https://www.willhaley.com/blog/debian-arm-qemu/ 


#### 1. 初始化镜像

下载和安装 debian arm32:
``` bash
bash 0-download.sh

bash 1-run1.sh
```

安装过程是分漫长（2h以上），我们已经在qemu 6（ubuntu 22.04 apt自带版本）和8(最新版)上确认正常。  

安全过程可能会出现上面的博客[1] 中提到的 boot loader 安装失败，最新版不会出现这个问题：   
``` text

┌────────────────┤ [!!] Install the GRUB boot loader ├────────────────┐
│                                                                     │
│                      GRUB installation failed                       │
│ The 'grub-pc' package failed to install into /target/. Without the  │
│ GRUB boot loader, the installed system will not boot.               │
│                                                                     │
│     <Go Back>                                        <Continue>     │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```   

如果Grub安装失败，可以选择：Continue without boot loader



不管gurb有没有安装失败，都选择继续安装，在完成安装之后不要重启，而是把Image里面的kernel复制出来，最终运行qemu需要用Image里面复制出来的Kernel。  

``` text
┌───────────────────┤ [!!] Finish the installation ├────────────────────┐
│                                                                       │
│                         Installation complete                         │
│ Installation is complete, so it is time to boot into your new system. │
│ Make sure to remove the installation media, so that you boot into the │
│ new system rather than restarting the installation.                   │
│                                                                       │
│     <Go Back>                                          <Continue>     │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```   
这里需要选择 Go Back，然后在命令行里面选择 Execute Shell，开启sshd，从qemu里面把kernel复制出来（这里也可以挂载qemu qcow2来复制）：

```
// qemu shell
# chroot /target/ sh -c "mkdir -p /var/run/sshd && /sbin/sshd -D"


// outside shell
$ bash 2-copy_kernel.sh
scp -P 5555 arm@localhost:/boot/vmlinuz vmlinuz-from-guest
scp -P 5555 arm@localhost:/boot/initrd.img initrd.img-from-guest
```
之后可以Ctrl-A + Ctrl-X退出 Qemu。  

#### 2. 运行qemu debian arm
完成步骤1中的初始化之后目录结构为：
```
qemu-arm
|-- 0-download.sh
|-- 1-run1.sh
|-- 2-copy_kernel.sh
|-- 3-run2.sh
|-- debian-12.1.0-armhf-DVD-1.iso
|-- debian-arm.sda.qcow2
|-- initrd.gz
|-- initrd.img-from-guest
|-- vmlinuz
`-- vmlinuz-from-guest
```

在一个shell启动qemu：
```
bash 3-run2.sh
```

就能ssh连进去：  
```
ssh -p 5555 arm@localhost
```

后面添加tuna源，安装docker.io，就可正常测试。  
