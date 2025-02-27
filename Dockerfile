# 指定基础镜像，必须为第一个命令
FROM registry.us-east-1.aliyuncs.com/istory_img/openjdk:8-adopt
# 维护者信息
MAINTAINER cai <caishuiqing@novmic.com>

ENV APP_ENV dev
ENV EXTRA_JVM_CONFIG ""
ENV EXTRA_JAVA_CONFIG ""

# 工作目录，
WORKDIR /app

CMD ls

# 添加 jar
ADD ./target/*.jar cai-user.jar

# 指定时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai'>/etc/timezone

VOLUME /app/logs

### 启动
ENTRYPOINT [ "sh", "-c", "exec java -XX:MaxRAMPercentage=80.0 -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/app/logs/gc-%t.log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/app/logs/dump.hprof ${EXTRA_JVM_CONFIG} -jar cai-user.jar --env ${APP_ENV} ${EXTRA_JAVA_CONFIG}" ]
