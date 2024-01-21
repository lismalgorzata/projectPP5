# Stage 1: Build the Vue.js app
FROM node:lts-alpine AS builder

# Install global dependencies with specific versions
RUN npm install -g http-server @vue/cli@latest axios@latest json-server@latest vuex@latest vue-router@latest

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the Vue.js app for production
RUN npm run build

# Stage 2: Create a smaller production image
FROM node:lts-alpine

# Set the working directory to /app
WORKDIR /app

# Create the dist directory
RUN mkdir dist

# Copy only necessary files from the builder image
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/package*.json /app/
COPY --from=builder /app/data /app/data

RUN ls -l /app
RUN ls -l /app/dist

# Add global npm bin directory to the PATH during runtime
ENV PATH /app/node_modules/.bin:$PATH

# Expose port 8080 for the Vue.js app
EXPOSE 8080

# Start the JSON server and the Vue.js app
CMD ["npm", "run", "json-server"]
