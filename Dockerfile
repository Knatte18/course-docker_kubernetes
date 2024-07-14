FROM node:18-alpine AS builder

# Create and set work dir
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# Install packages
COPY --chown=node:node ./package.json ./
RUN npm install

# Copy all other files
COPY --chown=node:node ./ ./

FROM nginx AS final
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html
