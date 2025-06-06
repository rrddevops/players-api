##Builder Image
FROM golang:1.17-stretch AS builder
ENV GO111MODULE=on
COPY . /players
WORKDIR /players
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o bin/application

#s Run Image
FROM scratch
COPY --from=builder /players/assets /assets
COPY --from=builder /players/bin/application application
EXPOSE 9999
ENTRYPOINT ["./application"]
