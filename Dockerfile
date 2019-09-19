FROM golang:1.13-alpine3.10 AS builder
RUN apk add --no-cache git gcc g++
RUN go get -v github.com/rubenv/sql-migrate/sql-migrate

FROM alpine:3.10
COPY --from=builder /go/bin/sql-migrate /bin/sql-migrate
RUN mkdir /migrations
WORKDIR /migrations
ENTRYPOINT ["sql-migrate"]
