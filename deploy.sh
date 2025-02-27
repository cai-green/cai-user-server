#!/bin/bash
app_name=${{secrets.MODULE_NAME}}
memory_limit=${{secrets.MEMORY_LIMIT}}
app_version=${{secrets.imageVersion}}
docker_image_url=${{docekrImageUrl}}
#===阿里云变量===

docker_name=${docker_image_url}${app_name}:${app_version:lastest}
env=DEV

# 消息
function message() {
  ret=$?
  state=$1
  fatalError=$2
  if [[ ${ret} -eq 0 ]]; then
    echo "==============================$state 成功!=============================="
  else
    echo "==============================$state 失败!=============================="
    if [[ -n $fatalError ]]; then
      echo "$state 出现致命错误!异常退出!"
      exit 2
    fi
  fi
}

#这里
docker pull "${docker_name}" 
message "更新镜像" "出现异常退出此脚本"

docker stop "${app_name}"
message "关闭容器"

docker rm "${app_name}"
message "删除容器"

docker run \
  --log-opt max-size=10m \
  --name="${app_name}" \
  --restart=always \
  --net=host \
  -m "${memory_limit}" \
  -v /var/log/app/"${app_name}":/app/logs \
  -d \
  -e APP_ENV="${env}" \
  "${docker_name}"

echo "==============================如果发生错误,请使用以下命令手动启动尝试=============================="
echo "docker run \
        --log-opt max-size=10m \
        --name=${app_name} \
        --restart=always \
        --net=host \
        -m ${memory_limit} \
        -v /var/log/app/${app_name}:/app/logs \
        -d \
        -e APP_ENV=${env} \
        ${docker_name}"
echo "==============================如果发生错误,请使用此命令手动启动尝试=============================="

message "启动容器" "出现异常退出此脚本"