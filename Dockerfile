FROM python:3.11-slim AS build

# Install Quarto
RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*
RUN curl -sLO https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.42/quarto-1.6.42-linux-amd64.deb && \
    dpkg -i quarto-1.6.42-linux-amd64.deb && \
    rm quarto-1.6.42-linux-amd64.deb

# Install Python dependencies
RUN pip install --no-cache-dir biopython pandas numpy matplotlib openai jupyter nbformat nbclient ipykernel

WORKDIR /app
COPY . .

# Build HTML
RUN quarto render --to html

# Production stage: serve with nginx
FROM nginx:alpine

# Copy built book
COPY --from=build /app/_book /usr/share/nginx/html

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
