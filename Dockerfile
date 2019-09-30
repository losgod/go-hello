FROM golang:1.11.0
WORKDIR /go/src/gowebdemo/
ENV GOPROXY=https://goproxy.io GO111MODULE=on
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o gowebdemo app.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/gowebdemo .
EXPOSE 8088
CMD ["timeout","120","./gowebdemo"]
