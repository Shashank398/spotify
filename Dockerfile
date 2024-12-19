# Use the official Node.js image as the base image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Add the environment variable for OpenSSL
ENV NODE_OPTIONS=--openssl-legacy-provider

# Copy the rest of the application code to the container
COPY . .

# Build the React application
RUN npm run build

# Use a lightweight web server to serve the build files
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]

