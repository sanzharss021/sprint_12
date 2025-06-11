FROM golang:1.23.3-alpine AS builder 

WORKDIR /app 

COPY go.mod . 

COPY go.sum . 

RUN go mod download 

COPY . . 

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main . 

FROM alpine:latest 

WORKDIR /app 

COPY --from=builder /app/main /app/ 

COPY tracker.db . 

CMD ["./main"]