# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./

RUN go build -o /backend-test-sagara-tech

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /backend-test-sagara-tech /backend-test-sagara-tech

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/backend-test-sagara-tech"]