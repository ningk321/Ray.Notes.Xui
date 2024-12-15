#!/bin/bash

# 从 GitHub 拉取最新的 deploy_containers.sh 脚本
curl -sSL https://raw.githubusercontent.com/ningk321/Ray.Notes.Xui/refs/heads/main/nginx/deploy_containers.sh -o deploy_containers.sh

# 给脚本赋予执行权限
chmod +x deploy_containers.sh

# 执行脚本
./deploy_containers.sh
