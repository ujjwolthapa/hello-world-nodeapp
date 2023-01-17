FROM node:18-alpine
WORKDIR /app
COPY . .
Run npm install -g nodemon
EXPOSE 3000
CMD nodemon -L app.js
