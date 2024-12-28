FROM node:14

# Set working directory
WORKDIR /usr/src/app

# Copy application files
COPY package*.json ./
COPY app.js .

# Install dependencies
RUN npm install

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
