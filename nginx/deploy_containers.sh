#!/bin/bash

# 检查是否为root用户
if [ "$(id -u)" -ne 0 ]; then
    echo "请使用root权限运行此脚本"
    exit 1
fi

# 显示菜单选项
echo "请选择数字:"
echo "1. 安装 Docker"
echo "2. 卸载 Docker"
echo "3. 安装 Portainer"
echo "4. 安装 Transmission"
echo "5. 安装 QB"
echo "6. 安装 Navidrome"
echo "7. 安装 Vaultwarden"
echo "8. 安装 Zoraxy"
echo "9. 安装 Cloudflared"
echo "10. 安装 Filebrowser"
echo "11. 安装 Stirling-PDF"
echo "12. 安装 Tailscale"
read -p "请输入选择: " choice

# 安装 Docker
install_docker() {
    if command -v docker &>/dev/null; then
        echo "Docker 已安装，版本为：$(docker --version)"
    else
        echo "Docker 未安装，正在安装..."
        apt-get update
        apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
        echo "Docker 安装完成！"
    fi
}

# 卸载 Docker
uninstall_docker() {
    if command -v docker &>/dev/null; then
        echo "正在卸载 Docker..."
        apt-get purge -y docker-ce docker-ce-cli containerd.io
        apt-get autoremove -y
        rm -rf /var/lib/docker
        echo "Docker 已卸载！"
    else
        echo "Docker 未安装！"
    fi
}

# 从 GitHub 拉取 docker-compose.yml 文件
fetch_docker_compose() {
    container_name=$1
    github_url="https://raw.githubusercontent.com/ningk321/spielen/main/docker-compose-files/$container_name.yml"
    
    echo "正在从 GitHub 拉取 $container_name 的 docker-compose.yml 文件..."
    mkdir -p /home/mike/App/$container_name
    cd /home/mike/App/$container_name

    # 使用 curl 拉取文件并重命名为 docker-compose.yml
    curl -O $github_url
    mv "$container_name.yml" docker-compose.yml

    # 使用 Docker Compose 启动容器
    docker compose up -d
    echo "$container_name 容器已部署！"
}

# 选择操作
case $choice in
    1)
        install_docker
        ;;
    2)
        uninstall_docker
        ;;
    3)
        fetch_docker_compose "Portainer"
        ;;
    4)
        fetch_docker_compose "Transmission"
        ;;
    5)
        fetch_docker_compose "QB"
        ;;
    6)
        fetch_docker_compose "Navidrome"
        ;;
    7)
        fetch_docker_compose "Vaultwarden"
        ;;
    8)
        fetch_docker_compose "Zoraxy"
        ;;
    9)
        fetch_docker_compose "Cloudflared"
        ;;
    10)
        fetch_docker_compose "Filebrowser"
        ;;
    11)
        fetch_docker_compose "Stirling-PDF"
        ;; 
    12)
        fetch_docker_compose "Tailscale"
        ;;    
    *)
        echo "无效选择，请选择1-12之间的数字！"
        ;;
esac
