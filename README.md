# ssr

## BBR

简介: [BBR加速](https://github.com/iMeiji/shadowsocks_install/wiki)

BBR 目的是要尽量跑满带宽, 并且尽量不要有排队的情况，效果并不比速锐差。Linux kernel 4.9+已支持tcp_bbr，下面简单讲述基于KVM架构VPS如何开启。

### 检查内核

```bash
uname -r
```

查看内核版本是否 `>= 4.9`，`4.18.0-147.3.1.el8_1.x86_64`。

### 检查 BBR

```bash
lsmod | grep bbr
```

如果有输出，则已开启，否则执行下面的 `启用 BBR`，已开启则不用。

如下，则已启用。

```bash
tcp_bbr                20480  7
```

### 启用 BBR

执行如下命令将参数写入 `/etc/sysctl.conf`

```bash
echo "net.core.default_qdisc=fq" | sudo tee --append /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee --append /etc/sysctl.conf
```

> 请注意，需要系统内核版本 `>= 4.9`。

执行下面的命令，立即生效，否则需要重启系统。

```bash
sudo sysctl -p
```

## Docker

### 安装

```bash
curl -fsSL https://get.docker.com | bash -
sudo usermod -aG docker $USER
```

> 第二行命令为将当前用户添加至 `docker` 用户组，如使用 `root` 用户则请忽略，或替换 `$USER` 为指定用户。

## 安装 `docker-compose`

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

上述命令会下载对应版本的 `docker-compose` 放置在 `/usr/local/bin/`，如果路径不在 `PATH` 路径里，请配置。

> 更多关于版本信息，或手动下载安装，请前往项目 [GitHub Release](https://github.com/docker/compose/releases)

配置命令补全:

```bash
curl -L https://raw.githubusercontent.com/docker/compose/1.25.5/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
```

关于 `docker-compose` 安装的另一份引导，可参阅 [Docker —— 从入门到实践](https://yeasy.gitbook.io/docker_practice/compose/install)
