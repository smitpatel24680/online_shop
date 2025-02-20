# React App with Docker and Nginx

## Overview
This project containerizes a React application using Docker and serves it with Nginx. The application was built using Vite, and the necessary configurations were made to ensure smooth deployment.

## Project Setup
The Dockerfile consists of two stages:
1. **Build Stage**: Uses a Node.js environment to install dependencies and build the React application.
2. **Production Stage**: Uses Nginx to serve the built files in a lightweight container.

## Modified Configurations
- The **Vite config (`vite.config.js`)** was modified to set up the correct base path and handle deployment settings.
- The **host port** used is `3000`, and the **container port** is `5137` because of how Vite builds the application.

## Dockerfile Breakdown
```dockerfile
# Step 1: Use a Node image to build the React app
FROM node:18 as build

WORKDIR /app

COPY package*.json ./

COPY . ./

RUN npm install

RUN npm run build

# Step 2: Use Nginx to serve the React app
FROM nginx:alpine

# Copy the build output (dist folder) to the nginx html directory
COPY --from=build /app/dist/ /usr/share/nginx/html/

# Expose the port Nginx will listen on
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
```

## Running the Container
### Build the Docker Image
```sh
docker build -t react-nginx-app:latest .
```

### Run the Container
```sh
docker run -d -p 3000:80 react-nginx-app:latest
```

The application will now be accessible at `http://localhost:3000`.

## Troubleshooting
- **Blank screen issue**: Ensure that the `vite.config.js` file is correctly set up for production.
- **Check Nginx logs**: If the app is not loading, check the logs inside the container:
  ```sh
  docker logs <container_id>
  ```
- **Verify built files**: Run `ls dist/` to ensure Vite has successfully built the project.

## Notes
- The `vite.config.js` file was modified to ensure proper deployment.
- Vite builds and serves on port `5137` inside the container.
- Ensure your React app is correctly built before running the container.

---
This setup allows seamless containerization and deployment of a React app using Docker and Nginx. 🚀


