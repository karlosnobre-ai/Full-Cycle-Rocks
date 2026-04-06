FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /app/fullcycle . && \
    apk add --no-cache upx && \
    upx --best /app/fullcycle

FROM scratch
COPY --from=builder /app/fullcycle /fullcycle
ENTRYPOINT ["/fullcycle"]
