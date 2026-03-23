# syntax=docker/dockerfile:1

FROM node:20-alpine

# Install required dependencies
RUN apk add --no-cache \
    git \
    curl \
    bash \
    openssh-client \
    ca-certificates

# Install OpenCode CLI globally
RUN npm install -g opencode-ai

# Create workspace directory for persistent storage
RUN mkdir -p /workspace && chmod 777 /workspace

# Set working directory
WORKDIR /workspace

# Create non-root user for security
RUN addgroup -g 1000 opencode && \
    adduser -D -u 1000 -G opencode opencode && \
    chown -R opencode:opencode /workspace

USER opencode

# Expose port (Railway will set PORT env var)
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:${PORT:-3000}/health || exit 1

# Start OpenCode Web server
CMD ["sh", "-c", "opencode web --hostname 0.0.0.0 --port ${PORT:-3000}"]
