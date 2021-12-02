# We use Node 14, because to Microsoft that is the latest Long-Term-Support-ed version of Node.
FROM node:14

# Set the working directory, this also does a cd command immidietly
WORKDIR /app

# Copy the contents of this directory
COPY . .

# Install the node packages
RUN npm install

# Define the environment variable for the port used and expose it at the same time.
ENV PORT=8080
EXPOSE ${PORT}

# Upon starting the container, run the application.
CMD ["npm", "start"]