# Use an official Node runtime as a parent image
FROM node:14 as builder

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install
RUN npm install -g @vue/cli
RUN npm install -g axios
RUN npm install -g json-server
RUN npm install -g vuex
RUN npm install -g vue-router

# Copy the rest of the application code to the working directory
COPY . .

# Build the Vue.js app for production
RUN npm run build

# Create a smaller production image
FROM node:14-alpine

# Set the working directory to /app
WORKDIR /app

# Copy only necessary files from the builder image
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/data /app/data

# Add global npm bin directory to the PATH during runtime
ENV PATH /app/node_modules/.bin:$PATH

# Expose port 8080 for the Vue.js app
EXPOSE 8080

# Start the JSON server and the Vue.js app
CMD ["npm", "run", "json-server"]
