#!/bin/bash

# 将 yum 源改为 aliyun 的
yes | mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
yes | wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yes | yum makecache

# 下载 python 需要的依赖
yes | yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make libffi-devel -y

# 下载 python，这里是 Python3.7.0
cd /usr/local/src/
yes | wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
yes | tar -zxvf Python-3.7.0.tgz -C /usr/local/share/

# 编译安装 Python
cd /usr/local/share/Python-3.7.0
yes | sh configure # 这里可以加前缀 --prefix=/${path}...
yes | make&&make install

# 建 python3 的软连接
ln -s /usr/local/bin/python3 /usr/bin/python3
