FROM golang:alpine as builders

WORKDIR /app

COPY main.go .
COPY go.mod .

RUN go mod download

COPY . .

RUN go build -v -o /serve 

FROM scratch

COPY --from=builders /serve /serve

ENTRYPOINT ["/serve"]