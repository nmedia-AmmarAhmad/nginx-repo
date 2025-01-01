# Use an official NGINX image as a base
FROM nginx:latest

# Copy the HTML and CSS files into the NGINX default directory
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
