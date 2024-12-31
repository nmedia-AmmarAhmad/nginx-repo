# Use the official NGINX image as the base image
FROM nginx:latest

# Copy the HTML and CSS files into the NGINX directory
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./styles.css /usr/share/nginx/html/style.css

# Expose port 80 (NGINX default)
EXPOSE 80

