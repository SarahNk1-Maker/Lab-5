# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
        clang \
        build-essential \
        && \
    rm -rf /var/lib/apt/lists/*

# Set up a working directory inside the container
WORKDIR /app

# Copy your C source code into the container
COPY sample.c .

# Compile the program with AddressSanitizer enabled
RUN clang -fsanitize=address -g -o sample sample.c

# Set default command to run the compiled program
CMD ["./sample", "50"]
