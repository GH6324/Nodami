FROM alpine:latest
RUN apk --no-cache add ca-certificates tzdata
WORKDIR /app
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


CMD ["/app/server"]

