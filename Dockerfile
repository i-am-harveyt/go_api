FROM        golang:1.22-alpine
RUN         mkdir -p /app
WORKDIR     /app
COPY        . .
RUN         go mod download && go build -o app
ENTRYPOINT  ["./app"]

