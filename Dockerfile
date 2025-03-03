# # Step 1: Use a Node image to build the React app
# FROM node:18 as build

# WORKDIR /app

# COPY package*.json ./

# COPY . ./

# RUN npm install

# RUN npm run build

# # Step 2: Use Nginx to serve the React app
# FROM nginx:alpine

# # Copy the build output (dist folder) to the nginx html directory
# COPY --from=build /app/dist/ /usr/share/nginx/html/

# # Expose the port Nginx will listen on
# EXPOSE 80

# # Start Nginx when the container runs
# CMD ["nginx", "-g", "daemon off;"]


# Stage 1 - Development
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2 - Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
EXPOSE 5173
CMD ["npm", "run", "dev"]

