FROM golang:1.15.0-alpine3.12 as builder

# 启用go module,海外构建，无需开启
# ENV GO111MODULE=on \
#     GOPROXY=https://goproxy.cn,direct

WORKDIR /app

COPY . .

# CGO_ENABLED禁用cgo 然后指定OS等，并go build
# 由于net包使用静态链接库(libc)，编译出的二进制运行环境要求有libc，这里使用纯go -tags netgo
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -tags netgo go-server.go

# 整理二进制文件
RUN mkdir publish && cp go-server publish

# 运行阶段指定scratch作为基础镜像
FROM scratch

WORKDIR /app

# 将上一个阶段publish文件夹下的所有文件复制进来
COPY --from=builder /app/publish .

ENTRYPOINT ["./go-server"]




