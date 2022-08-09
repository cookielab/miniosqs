FROM golang:1.18-alpine AS build

WORKDIR /app/miniosqs

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

WORKDIR /app/miniosqs/cmd
RUN go build -o ./out/miniosqs .

FROM alpine:3.16

COPY --from=build /app/miniosqs/cmd/out/miniosqs /usr/local/bin/miniosqs

ENTRYPOINT ["/usr/local/bin/miniosqs"]