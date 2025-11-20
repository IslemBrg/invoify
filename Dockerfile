# --- Build Stage ---
    FROM node:22-alpine AS build

    WORKDIR /app
    
    COPY package.json yarn.lock ./
    RUN yarn install --frozen-lockfile
    
    COPY . .
    
    RUN yarn build
    
    
    # --- Production Stage ---
    FROM node:22-alpine AS production
    
    WORKDIR /app
    
    COPY --from=build /app/.next/standalone ./
    COPY --from=build /app/.next/static ./.next/static
    COPY --from=build /app/public ./public
    
    EXPOSE 3000
    
    CMD ["node", "server.js"]
    