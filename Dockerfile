FROM node:18.18.0-alpine AS builder

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
COPY prisma ./prisma

RUN corepack enable pnpm && pnpm install --frozen-lockfile

COPY . .

RUN pnpm build

FROM node:18.18.0-alpine AS runner

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/email-templates ./email-templates
COPY --from=builder /app/public ./public

CMD [ "node", "dist/src/entry.js", "start" ]