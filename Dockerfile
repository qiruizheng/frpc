# 选择基础镜像  
FROM alpine:latest  

# 设置环境变量  
ENV FRPC_VERSION=0.60.0 
# 请替换为你想使用的版本  
ENV FRPC_PATH=/frp/frpc  

# 安装必要的工具  
RUN apk add --no-cache \
    wget \
    tar \
    && mkdir -p /frp \
    && cd /frp \
    && wget https://github.com/fatedier/frp/releases/download/v${FRPC_VERSION}/frp_${FRPC_VERSION}_linux_amd64.tar.gz -O frp.tar.gz \
    && tar -xzf frp.tar.gz \
    && mv frp_${FRPC_VERSION}_linux_amd64/frpc . \
    && rm -rf frp.tar.gz frp_${FRPC_VERSION}_linux_amd64  

# 复制配置文件  
COPY frpc.toml /frp/frpc.toml  

# 设置工作目录  
WORKDIR /frp  
VOLUME /frp
# 启动 FRPC  
CMD ["./frpc", "-c", "frpc.toml"]
