FROM node:gallium

WORKDIR /app

COPY tsconfig.json ./
COPY package.json ./
COPY package-lock.json ./
COPY src src/
COPY scripts/start-app.sh ./

RUN npm ci && npm i -g fastify-cli

RUN npm run build && \
  npm ci --only=production && \
  npx node-prune ./node_modules

ENV NODE_ENV=production
ENV LOG_LEVEL=info

CMD ["./start-app.sh"]
