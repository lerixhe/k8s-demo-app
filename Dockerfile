FROM golang:1.15.0-alpine3.12
workdir /app
copy . /app/
run go build go-server.go
entrypoint ["./go-server"]
