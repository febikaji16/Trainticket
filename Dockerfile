# Multi-stage Dockerfile for Flutter Web Application

# Stage 1: Build the Flutter web app
FROM debian:stable-slim AS build-env

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git wget unzip gdb libstdc++6 \
    libglu1-mesa fonts-droid-fallback python3 ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone Flutter repository
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run Flutter doctor
RUN flutter doctor -v

# Enable Flutter web
RUN flutter channel stable && \
    flutter upgrade && \
    flutter config --enable-web

# Create app directory
WORKDIR /app

# Copy app files
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the web application
RUN flutter build web --release

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the built web app from build stage
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Copy custom nginx configuration (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
