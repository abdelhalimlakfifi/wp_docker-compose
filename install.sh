#!/bin/bash

# Prompt user for WordPress port
read -p "Enter the port you want WordPress to run on (default 8082): " WP_PORT
WP_PORT=${WP_PORT:-8082}

# Prompt user for phpMyAdmin port
read -p "Enter the port you want phpMyAdmin to run on (default 8081): " PMA_PORT
PMA_PORT=${PMA_PORT:-8081}

# Replace ports in docker-compose.yml
sed -i "s/[0-9]\{4\}:80\" # WordPress port/\"$WP_PORT:80\"/" docker-compose.yml
sed -i "s/[0-9]\{4\}:80\" # phpMyAdmin port/\"$PMA_PORT:80\"/" docker-compose.yml

# If there are no comments, you can do a simpler line-based replacement
sed -i "s/\"[0-9]*:80\"/\"$WP_PORT:80\"/" docker-compose.yml
sed -i "0,/\"[0-9]*:80\"/s/\"[0-9]*:80\"/\"$PMA_PORT:80\"/" docker-compose.yml

echo "Starting Docker containers..."
docker-compose up -d

echo "✅ WordPress is running on http://localhost:$WP_PORT"
echo "✅ phpMyAdmin is running on http://localhost:$PMA_PORT"
