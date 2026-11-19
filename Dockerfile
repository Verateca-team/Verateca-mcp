# Verateca MCP for clients that start MCP servers as local Docker containers.
# The Verateca server itself runs at https://verateca.com/mcp (Streamable HTTP,
# no account, read-only). This image only bridges standard input/output to it.
FROM node:22-alpine
LABEL org.opencontainers.image.title="Verateca MCP" \
      org.opencontainers.image.description="Verateca — the practical guide to supplements for AI assistants. Remote MCP: https://verateca.com/mcp" \
      org.opencontainers.image.url="https://verateca.com" \
      org.opencontainers.image.source="https://github.com/Verateca/Verateca-mcp"
RUN npm install -g mcp-remote@0.16.7 && npm cache clean --force
USER node
ENTRYPOINT ["mcp-remote", "https://verateca.com/mcp"]
