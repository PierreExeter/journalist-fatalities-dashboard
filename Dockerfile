FROM metabase/metabase:latest

EXPOSE 3000

# Add health check for Render
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3000/api/health || exit 1

# Set environment variables for Metabase
ENV MB_DB_TYPE=postgres
ENV MB_DB_HOST=${MB_DB_HOST}
ENV MB_DB_PORT=${MB_DB_PORT}
ENV MB_DB_NAME=${MB_DB_NAME}
ENV MB_DB_USER=${MB_DB_USER}
ENV MB_DB_PASS=${MB_DB_PASS}
ENV MB_SITE_URL=${MB_SITE_URL}
