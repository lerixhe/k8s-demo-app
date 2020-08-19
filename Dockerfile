FROM golang:1.15.0-alpine3.12
WORKDIR /app
COPY . /app/
RUM go build go-server.go
ENTRYPOINT ["./go-server"]
