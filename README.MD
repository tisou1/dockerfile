




## 构建命令
`docker build -t front .`

## 创建容器

`docker run --name myFront -it front:v1 /bin/zsh`

以镜像`front:v1`来构建一个名为`myFront`的容器,并且以zsh打开命令行
> 在dockerfile中我们安装了zsh

## 启动容器
`docker run myFront`

## 进入容器
`docker exec -it myFront /bin/bash`

这里-t指定构建出来的镜像名称
. 指代当前目录


> linux命令查询 [链接](https://wangchujiang.com/linux-command/)