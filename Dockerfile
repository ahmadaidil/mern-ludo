FROM node:14-alpine as frontend
WORKDIR /app
COPY . /app
ARG REACT_APP_HOST_URL
RUN npm install --production
RUN npm run build

FROM node:14-alpine as backend
WORKDIR /app
COPY /backend /app
RUN npm install

FROM node:14-alpine
WORKDIR /app
COPY --from=backend /app /app/
COPY --from=frontend /app/build /app/build

EXPOSE 8080

CMD ["npm", "run", "start"]
