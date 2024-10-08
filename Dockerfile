
# Start from the official Golang base image
FROM golang:1.22 AS build

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules manifests
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o main .

# Start a new stage from scratch
FROM alpine:latest

# Install necessary packages
RUN apk --no-cache add ca-certificates

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=build /app/main .

# Ensure the binary has execution permissions
RUN chmod +x /root/main

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]


# # Start from the official Golang base image
# FROM golang:1.22 AS build

# # Set the Current Working Directory inside the container
# WORKDIR /app

# # Copy the Go Modules manifests
# COPY go.mod go.sum ./

# # Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
# RUN go mod download

# # Copy the source code into the container
# COPY . .

# # Build the Go app
# RUN go build -o main .

# # Start a new stage from scratch
# FROM alpine:latest  

# # Install necessary packages
# RUN apk --no-cache add ca-certificates

# # Set the Current Working Directory inside the container
# WORKDIR /root/

# # Copy the Pre-built binary file from the previous stage
# COPY --from=build /app/main .

# # Expose port 8080 to the outside world
# EXPOSE 8080

# # Command to run the executable
# CMD ["./main"]
