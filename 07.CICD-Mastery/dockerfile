# Use the official NGINX base image
FROM nginx:latest

# Set the working directory in the container
WORKDIR  /usr/share/nginx/html/

# Copy the local HTML file to the NGINX default public directory
COPY ./Signup_page/ /usr/share/nginx/html/

# Expose port 80 to allow external access
EXPOSE 80


